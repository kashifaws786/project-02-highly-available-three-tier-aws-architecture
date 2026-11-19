
output "alb_id" {
  description = "ID of the Application Load Balancer"
  value       = aws_lb.main.id
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.main.arn
}

output "alb_dns_name" {
  description = "DNS name used to access the application"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Route 53 hosted zone ID of the ALB"
  value       = aws_lb.main.zone_id
}

output "target_group_arn" {
  description = "ARN of the application Target Group"
  value       = aws_lb_target_group.app.arn
}

output "autoscaling_group_name" {
  description = "Name of the application Auto Scaling Group"
  value       = aws_autoscaling_group.app.name
}

output "launch_template_id" {
  description = "ID of the EC2 Launch Template"
  value       = aws_launch_template.app.id
}

output "alb_arn_suffix" {
  description = "ARN suffix of the Application Load Balancer for CloudWatch metrics"
  value       = aws_lb.main.arn_suffix
}

output "target_group_arn_suffix" {
  description = "ARN suffix of the application Target Group for CloudWatch metrics"
  value       = aws_lb_target_group.app.arn_suffix
}