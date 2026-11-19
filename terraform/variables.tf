
variable "project_name" {
  description = "Name of the AWS project"
  type        = string
  default     = "three-tier-architecture"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "db_username" {
  description = "Master username for the RDS MySQL database"
  type        = string
  sensitive   = true
}