locals {
  environment  = "dev"
  app_name     = "notification"
  name_prefix  = "${local.environment}-${local.app_name}"
  
  allowed_sg_names = ["dev-otms-alb-sg"]
}


data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "snaatak-p14-tfstatefile"
    key    = "env/dev/modules/network-skeleton/terraform.tfstate"
    region = "us-east-1"
  }
}

# Fetch SG ID dynamically by name
data "aws_security_group" "dynamic_sgs" {
  for_each = toset(local.allowed_sg_names)

  filter {
    name   = "group-name"
    values = [each.value]
  }

  filter {
    name   = "vpc-id"
    values = [data.terraform_remote_state.network.outputs.vpc_id]
  }
}

module "ec2_instance" {
  source        = "./module"

  ami_id        = "ami-0f480532aec0003f8"
  instance_type = "t2.small"
  key_name      = "otms"
  sg_name       = local.name_prefix
  vpc_id        = data.terraform_remote_state.network.outputs.vpc_id
  subnet_id     = data.terraform_remote_state.network.outputs.private_subnet_ids["api-subnet"]

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["20.0.0.0/27"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  allowed_sg_ingress_rules = [
    for sg in data.aws_security_group.dynamic_sgs :
    {
      from_port                = 5000
      to_port                  = 5000
      protocol                 = "tcp"
      source_security_group_id = sg.id
    }
  ]
}
