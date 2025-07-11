output "instance_id" {
  description = "ID of the private EC2 instance"
  value       = module.ec2_instance.instance_id
}

output "private_ip" {
  description = "Private IP of the EC2 instance"
  value       = module.ec2_instance.private_ip
}

output "security_group_id" {
  description = "ID of the security group created for the instance"
  value       = module.ec2_instance.security_group_id
}
