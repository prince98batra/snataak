resource "null_resource" "create_key_pair_if_missing" {
  provisioner "local-exec" {
    command = <<EOT
      set -euo pipefail

      mkdir -p ~/.ssh

      if ! aws ec2 describe-key-pairs --key-names ${var.key_name} --region us-west-1 >/dev/null 2>&1; then
        echo "Creating key pair '${var.key_name}' in us-west-1..."
        aws ec2 create-key-pair \
          --key-name ${var.key_name} \
          --query 'KeyMaterial' \
          --output text \
          --region us-west-1 > ~/${var.key_name}.pem

        chmod 400 ~/${var.key_name}.pem
        echo "Key pair '${var.key_name}' created and saved to ~/${var.key_name}.pem"
      else
        echo "Key pair '${var.key_name}' already exists. Skipping creation."
      fi

      cat ~/${var.key_name}.pem
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

  triggers = {
    always_run = timestamp()
  }
}


# Create security group
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

  tags = {
    Name = var.sg_name
  }
}

# Launch EC2 instance
resource "aws_instance" "ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [aws_security_group.main_sg.id]

  tags = {
    Name = var.sg_name
  }

  depends_on = [null_resource.create_key_pair_if_missing]
}
