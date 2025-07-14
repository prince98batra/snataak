output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.app_lt.id
}

output "launch_template_latest_version" {
  description = "Latest Launch Template Version"
  value       = aws_launch_template.app_lt.latest_version
}

output "target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.app_tg.arn
}

output "target_group_name" {
  description = "Target Group Name"
  value       = aws_lb_target_group.app_tg.name
}

output "asg_name" {
  description = "Auto Scaling Group Name"
  value       = aws_autoscaling_group.app_asg.name
}

output "asg_arn" {
  description = "Auto Scaling Group ARN"
  value       = aws_autoscaling_group.app_asg.arn
}

output "scaling_policy_arn" {
  description = "Scaling Policy ARN"
  value       = aws_autoscaling_policy.cpu_tracking.arn
}

output "http_listener_arn" {
  description = "HTTP Listener ARN"
  value       = try(aws_lb_listener.http[0].arn, null)
}

output "https_listener_arn" {
  description = "HTTPS Listener ARN"
  value       = try(aws_lb_listener.https[0].arn, null)
}

output "listener_rule_arn" {
  description = "ALB Listener Rule ARN"
  value       = var.is_frontend ? try(aws_lb_listener_rule.http_rule[0].arn, null) : try(aws_lb_listener_rule.backend_rule[0].arn, null)
}

output "security_group_name_generated" {
  description = "Generated Security Group Name"
  value       = aws_security_group.main_sg.name
}

output "security_group_id_generated" {
  description = "Generated Security Group ID (used for internal rules)"
  value       = aws_security_group.main_sg.id
}

output "security_group_id" {
  description = "Passed Security Group ID (used in launch template)"
  value       = var.security_group_id
}

output "subnet_id" {
  description = "Subnet ID passed to ASG"
  value       = var.subnet_id
}

output "key_pair_name" {
  description = "SSH Key Pair Name used for instances"
  value       = var.key_name
}
