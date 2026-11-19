
variable "name_prefix" {
  description = "Common prefix used for database resource names"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs used by the RDS subnet group"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID attached to the RDS database"
  type        = string
}

variable "db_name" {
  description = "Initial MySQL database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username for the MySQL database"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "RDS database instance class"
  type        = string
  default     = "db.t3.micro"
}
