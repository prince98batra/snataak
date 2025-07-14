# -------------------------------------------------------------------
# Key Pair - Create if missing and upload to S3
# -------------------------------------------------------------------
resource "null_resource" "create_key_pair_if_missing" {
  provisioner "local-exec" {
    command = <<EOT
      set -euo pipefail

      KEY_NAME="${var.key_name}"
      REGION="${var.aws_region}"
      S3_BUCKET="${var.keypair_s3_bucket}"
      S3_OBJECT_PATH="env/${var.environment}/key-pair/$${KEY_NAME}.pem"
      TEMP_KEY_PATH=$(mktemp)

      if ! aws ec2 describe-key-pairs --key-names "$${KEY_NAME}" --region "$${REGION}" >/dev/null 2>&1; then
        echo "Key pair '$${KEY_NAME}' not found in AWS. Creating..."

        aws ec2 create-key-pair \
          --key-name "$${KEY_NAME}" \
          --query 'KeyMaterial' \
          --output text \
          --region "$${REGION}" > "$${TEMP_KEY_PATH}"

        chmod 400 "$${TEMP_KEY_PATH}"

        echo "Uploading key to S3: s3://$${S3_BUCKET}/$${S3_OBJECT_PATH}"
        aws s3 cp "$${TEMP_KEY_PATH}" "s3://$${S3_BUCKET}/$${S3_OBJECT_PATH}"

        echo "Key pair created and uploaded to S3"
      else
        echo "Key pair '$${KEY_NAME}' exists in AWS."

        echo "Checking if key exists in S3..."
        if aws s3 ls "s3://$${S3_BUCKET}/$${S3_OBJECT_PATH}" >/dev/null 2>&1; then
          echo "Key already present in S3: s3://$${S3_BUCKET}/$${S3_OBJECT_PATH}"
        else
          echo "Error: Key exists in AWS but not found in S3. Please upload it manually."
          exit 1
        fi
      fi

      rm -f "$${TEMP_KEY_PATH}" || true
    EOT

    interpreter = ["/bin/bash", "-c"]
  }

  triggers = {
    key_name = var.key_name
  }
}

# -------------------------------------------------------------------
# Security Group - Reusable and Safe
# -------------------------------------------------------------------
resource "aws_security_group" "main_sg" {
  name        = var.sg_name
  vpc_id      = var.vpc_id
  description = "Security group for EC2 instance"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "ingress" {
    for_each = var.allowed_sg_ingress_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      security_groups = [ingress.value.source_security_group_id]
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(var.standard_tags, {
    Name = var.sg_name
  })
}

# Launch Template
resource "aws_launch_template" "app_lt" {
  name_prefix   = "${var.name_prefix}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.disk_size
      volume_type = "gp2"
    }
  }

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip
    security_groups             = [aws_security_group.main_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.standard_tags, {
      Name = var.name_prefix
    })
  }
}

# Target Group
resource "aws_lb_target_group" "app_tg" {
  name        = "${var.name_prefix}-tg"
  port        = var.target_group_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = var.health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = var.standard_tags
}

# Auto Scaling Group
resource "aws_autoscaling_group" "app_asg" {
  name                = "${var.name_prefix}-asg"
  max_size            = var.max_size
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = [var.subnet_id]

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.app_tg.arn]

  tag {
    key                 = "Name"
    value               = var.name_prefix
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.standard_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

# Scaling Policy
resource "aws_autoscaling_policy" "cpu_tracking" {
  name                   = "${var.name_prefix}-cpu-tracking"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.cpu_target_value
  }
}

# HTTP Listener (frontend only)
resource "aws_lb_listener" "http" {
  count = var.is_frontend ? 1 : 0

  load_balancer_arn = var.alb_arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  tags = var.standard_tags
}

# HTTPS Listener (frontend only)
resource "aws_lb_listener" "https" {
  count = var.is_frontend && var.certificate_arn != null ? 1 : 0

  load_balancer_arn = var.alb_arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  tags = var.standard_tags
}

# HTTP Listener Rule (frontend only)
resource "aws_lb_listener_rule" "http_rule" {
  count = var.is_frontend ? 1 : 0

  listener_arn = aws_lb_listener.http[0].arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  tags = var.standard_tags
}

# HTTPS Listener Rule (for backend services)
resource "aws_lb_listener_rule" "backend_rule" {
  count = !var.is_frontend ? 1 : 0

  listener_arn = data.aws_alb_listener.https[0].arn
  priority     = var.listener_priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  condition {
    path_pattern {
      values = var.listener_paths
    }
  }

  tags = var.standard_tags
}

# Data source to get the existing HTTPS listener
data "aws_alb_listener" "https" {
  count = !var.is_frontend ? 1 : 0

  load_balancer_arn = var.alb_arn
  port              = 443
}
