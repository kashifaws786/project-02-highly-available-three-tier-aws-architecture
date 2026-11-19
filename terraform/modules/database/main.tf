
# Create a highly available MySQL RDS database.

resource "aws_db_instance" "main" {
  identifier = "${var.name_prefix}-mysql-db"

  engine         = "mysql"
  engine_version = "8.0"
  instance_class = var.instance_class

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name                     = var.db_name
  username                    = var.db_username
  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.security_group_id]

  multi_az            = true
  publicly_accessible = false
  port                = 3306

  backup_retention_period = 7
  backup_window           = "02:00-03:00"
  maintenance_window      = "Sun:03:00-Sun:04:00"

  auto_minor_version_upgrade = true
  deletion_protection        = false
  skip_final_snapshot        = true

  tags = {
    Name = "${var.name_prefix}-mysql-db"
    Tier = "Database"
  }
}