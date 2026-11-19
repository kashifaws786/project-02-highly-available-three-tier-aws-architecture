
# Create an IAM role for the application EC2 instances.

resource "aws_iam_role" "app" {
  name = "${var.name_prefix}-app-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${var.name_prefix}-app-ec2-role"
  }
}

# Attach the AWS managed policy required for Systems Manager access.

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.app.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create an instance profile to make the IAM role available to EC2.

resource "aws_iam_instance_profile" "app" {
  name = "${var.name_prefix}-app-instance-profile"
  role = aws_iam_role.app.name

  tags = {
    Name = "${var.name_prefix}-app-instance-profile"
  }
}

# Allow EC2 application instances to retrieve only their RDS database secret.

resource "aws_iam_role_policy" "database_secret_access" {
  name = "${var.name_prefix}-database-secret-access"
  role = aws_iam_role.app.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue"
        ]

        Resource = var.db_secret_arn
      }
    ]
  })
}
