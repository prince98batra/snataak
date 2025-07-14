output "launch_template_id" {
  description = "Launch template ID"
  value       = aws_launch_template.app_lt.id
}

output "launch_template_latest_version" {
  description = "Latest version of launch template"
  value       = aws_launch_template.app_lt.latest_version
}

output "target_group_arn" {
  description = "Target group ARN"
  value       = aws_lb_target_group.app_tg.arn
}

output "target_group_name" {
  description = "Target group name"
  value       = aws_lb_target_group.app_tg.name
}

output "asg_name" {
  description = "ASG name"
  value       = aws_autoscaling_group.app_asg.name
}

output "asg_arn" {
  description = "ASG ARN"
  value       = aws_autoscaling_group.app_asg.arn
}

output "scaling_policy_arn" {
  description = "Scaling policy ARN"
  value       = aws_autoscaling_policy.cpu_tracking.arn
}

output "http_listener_arn" {
  description = "HTTP listener ARN"
  value       = try(aws_lb_listener.http[0].arn, null)
}

output "https_listener_arn" {
  description = "HTTPS listener ARN"
  value       = try(aws_lb_listener.https[0].arn, null)
}

output "security_group_name_generated" {
  description = "Name of the generated security group"
  value       = aws_security_group.main_sg.name
}

output "listener_rule_arn" {
  description = "Listener rule ARN"
  value       = var.is_frontend ? try(aws_lb_listener_rule.http_rule[0].arn, null) : try(aws_lb_listener_rule.backend_rule[0].arn, null)
}

output "security_group_id" {
  description = "Security group ID used by launch template"
  value       = var.security_group_id
}

output "subnet_id" {
  description = "Subnet ID used by ASG"
  value       = var.subnet_id
}

output "security_group_id_generated" {
  description = "ID of the generated security group"
  value       = aws_security_group.main_sg.id
}

output "key_pair_name" {
  description = "Name of the key pair used"
  value       = var.key_name
}
