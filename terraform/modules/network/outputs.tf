
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "availability_zones" {
  description = "Availability Zones used by the network"
  value       = var.availability_zones
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "app_subnet_ids" {
  description = "IDs of the private application subnets"
  value       = aws_subnet.app[*].id
}

output "db_subnet_ids" {
  description = "IDs of the private database subnets"
  value       = aws_subnet.db[*].id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}


output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways"
  value       = aws_nat_gateway.main[*].id
}

output "nat_gateway_public_ips" {
  description = "Public Elastic IP addresses assigned to the NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}

output "app_route_table_ids" {
  description = "IDs of the application route tables"
  value       = aws_route_table.app[*].id
}

output "db_route_table_ids" {
  description = "IDs of the database route tables"
  value       = aws_route_table.db[*].id
}
