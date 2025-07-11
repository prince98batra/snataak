resource "null_resource" "create_key_pair_if_missing" {
  provisioner "local-exec" {
    command = <<EOT
      set -euo pipefail

      KEY_NAME="${var.key_name}"
      REGION="us-west-1"
      S3_BUCKET="snaatak-p14-tfstatefile"
      S3_OBJECT_PATH="env/dev/key-pair/$${KEY_NAME}.pem"
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
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.main_sg.id]

  tags = {
    Name = var.instance_name
  }

  depends_on = [null_resource.create_key_pair_if_missing]
}
