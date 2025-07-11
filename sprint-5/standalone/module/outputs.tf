output "instance_id" {
  value = aws_instance.ec2.id
}

output "private_ip" {
  value = aws_instance.ec2.private_ip
}

output "security_group_id" {
  value = aws_security_group.main_sg.id
}
