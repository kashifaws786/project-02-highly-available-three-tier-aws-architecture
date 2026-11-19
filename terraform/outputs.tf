
output "project_name" {
  description = "Name of the AWS project"
  value       = var.project_name
}

output "aws_region" {
  description = "AWS region used for deployment"
  value       = var.aws_region
}

output "availability_zones" {
  description = "Availability Zones selected for the project"
  value       = local.availability_zones
}

output "resource_name_prefix" {
  description = "Common naming prefix for AWS resources"
  value       = local.name_prefix
}

# Network module outputs.

output "vpc_id" {
  description = "ID of the project VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.network.public_subnet_ids
}

output "app_subnet_ids" {
  description = "IDs of the private application subnets"
  value       = module.network.app_subnet_ids
}

output "db_subnet_ids" {
  description = "IDs of the private database subnets"
  value       = module.network.db_subnet_ids
}

output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways"
  value       = module.network.nat_gateway_ids
}

output "nat_gateway_public_ips" {
  description = "Public IP addresses of the NAT Gateways"
  value       = module.network.nat_gateway_public_ips
}

# Security module outputs.

output "alb_security_group_id" {
  description = "ID of the ALB security group"
  value       = module.security.alb_security_group_id
}

output "app_security_group_id" {
  description = "ID of the application security group"
  value       = module.security.app_security_group_id
}

output "db_security_group_id" {
  description = "ID of the database security group"
  value       = module.security.db_security_group_id
}

# Compute module outputs.

output "alb_dns_name" {
  description = "DNS name used to access the application"
  value       = module.compute.alb_dns_name
}

output "autoscaling_group_name" {
  description = "Name of the application Auto Scaling Group"
  value       = module.compute.autoscaling_group_name
}

output "launch_template_id" {
  description = "ID of the EC2 Launch Template"
  value       = module.compute.launch_template_id
}

# Database module outputs.

output "db_instance_id" {
  description = "Identifier of the RDS database instance"
  value       = module.database.db_instance_id
}

output "db_endpoint" {
  description = "Endpoint address of the RDS MySQL database"
  value       = module.database.db_endpoint
}

output "db_port" {
  description = "Port used by the RDS MySQL database"
  value       = module.database.db_port
}

output "db_name" {
  description = "Name of the initial database"
  value       = module.database.db_name
}

output "db_subnet_group_name" {
  description = "Name of the RDS subnet group"
  value       = module.database.db_subnet_group_name
}