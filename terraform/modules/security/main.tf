# Security group for the Application Load Balancer.

resource "aws_security_group" "alb" {
  name        = "${var.name_prefix}-alb-sg"
  description = "Allow HTTP traffic from the internet"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP traffic from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-alb-sg"
  }
}

# Security group for private application EC2 instances.

resource "aws_security_group" "app" {
  name        = "${var.name_prefix}-app-sg"
  description = "Allow application traffic only from the ALB"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow HTTP traffic from the ALB"
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-app-sg"
  }
}


# Security group for the private RDS MySQL database.

resource "aws_security_group" "db" {
  name        = "${var.name_prefix}-db-sg"
  description = "Allow MySQL traffic only from application EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow MySQL traffic from application instances"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-db-sg"
  }
}
