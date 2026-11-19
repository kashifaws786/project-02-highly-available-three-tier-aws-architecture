
output "db_instance_id" {
  description = "Identifier of the RDS database instance"
  value       = aws_db_instance.main.id
}

output "db_endpoint" {
  description = "Endpoint address of the RDS MySQL database"
  value       = aws_db_instance.main.address
}

output "db_port" {
  description = "Port used by the RDS MySQL database"
  value       = aws_db_instance.main.port
}

output "db_name" {
  description = "Name of the initial database"
  value       = aws_db_instance.main.db_name
}

output "db_subnet_group_name" {
  description = "Name of the RDS subnet group"
  value       = aws_db_subnet_group.main.name
}

output "db_secret_arn" {
  description = "ARN of the AWS-managed RDS master user secret"
  value       = aws_db_instance.main.master_user_secret[0].secret_arn
}