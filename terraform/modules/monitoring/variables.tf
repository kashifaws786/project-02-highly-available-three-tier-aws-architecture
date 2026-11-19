
variable "name_prefix" {
  description = "Common prefix used for monitoring resource names"
  type        = string
}

variable "alb_arn_suffix" {
  description = "ARN suffix of the Application Load Balancer"
  type        = string
}

variable "target_group_arn_suffix" {
  description = "ARN suffix of the application target group"
  type        = string
}

variable "autoscaling_group_name" {
  description = "Name of the application Auto Scaling Group"
  type        = string
}

variable "db_instance_id" {
  description = "Identifier of the RDS database instance"
  type        = string
}

variable "aws_region" {
  description = "AWS region used by CloudWatch dashboard widgets"
  type        = string
}