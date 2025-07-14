variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "application_name" {
  description = "Application name"
  type        = string
}

variable "alb_name" {
  description = "ALB name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "security_group_name" {
  description = "Security group name"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
}

variable "target_group_port" {
  description = "Target group port"
  type        = number
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
}

variable "is_frontend" {
  description = "Is frontend application"
  type        = bool
  default     = false
}

variable "certificate_arn" {
  description = "Certificate ARN for HTTPS"
  type        = string
  default     = null
}

variable "ssl_policy" {
  description = "SSL policy"
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "listener_paths" {
  description = "Listener paths"
  type        = list(string)
  default     = ["/*"]
}

variable "listener_priority" {
  description = "Listener priority"
  type        = number
}

variable "min_size" {
  description = "Minimum ASG size"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum ASG size"
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "Desired ASG capacity"
  type        = number
  default     = 1
}

variable "cpu_target_value" {
  description = "Target CPU utilization"
  type        = number
  default     = 70
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "associate_public_ip" {
  description = "Whether to associate public IP"
  type        = bool
  default     = false
}

variable "security_group_id" {
  description = "Security group ID for instances"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for target group"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for ASG"
  type        = string
}

variable "alb_arn" {
  description = "ALB ARN for listeners"
  type        = string
}

variable "standard_tags" {
  description = "Standard tags"
  type        = map(string)
  default     = {}
}

variable "keypair_s3_bucket" {
  description = "S3 bucket name to store key pair PEM file"
  type        = string
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
}

variable "ingress_rules" {
  description = "List of CIDR-based ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "allowed_sg_ingress_rules" {
  description = "List of SG-based ingress rules"
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    source_security_group_id = string
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}
