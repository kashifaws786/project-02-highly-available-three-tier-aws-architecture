
variable "name_prefix" {
  description = "Common prefix used for compute resource names"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where compute resources will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs used by the Application Load Balancer"
  type        = list(string)
}

variable "app_subnet_ids" {
  description = "Private application subnet IDs used by the Auto Scaling Group"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID attached to the Application Load Balancer"
  type        = string
}

variable "app_security_group_id" {
  description = "Security group ID attached to EC2 application instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for application servers"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2023 AMI ID for the EC2 instances"
  type        = string
}

variable "min_size" {
  description = "Minimum number of EC2 instances in the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of EC2 instances in the Auto Scaling Group"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances in the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "db_secret_arn" {
  description = "ARN of the RDS master user secret in AWS Secrets Manager"
  type        = string
}

variable "aws_region" {
  description = "AWS region used by the application to access Secrets Manager"
  type        = string
}

variable "app_source_base64" {
  description = "Base64-encoded Flask application source code"
  type        = string
}

variable "requirements_base64" {
  description = "Base64-encoded Python application dependencies"
  type        = string
}