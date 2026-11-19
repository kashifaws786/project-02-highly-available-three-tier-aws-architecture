variable "name_prefix" {
  description = "Common prefix used for security resource names"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where security groups will be created"
  type        = string
}

variable "app_port" {
  description = "Port used by the application running on EC2"
  type        = number
  default     = 80
}

variable "db_port" {
  description = "Port used by the MySQL database"
  type        = number
  default     = 3306
}