
# Create an RDS subnet group across both private database subnets.

resource "aws_db_subnet_group" "main" {
  name        = "${var.name_prefix}-db-subnet-group"
  description = "Private database subnets across two Availability Zones"

  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.name_prefix}-db-subnet-group"
    Tier = "Database"
  }
}
