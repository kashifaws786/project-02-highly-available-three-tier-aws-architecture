
# Create a Launch Template for the application EC2 instances.

resource "aws_launch_template" "app" {
  name_prefix   = "${var.name_prefix}-app-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    var.app_security_group_id
  ]

  iam_instance_profile {
    name = aws_iam_instance_profile.app.name
  }

  # Encrypt the EC2 root EBS volume.

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 8
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  user_data = base64encode(templatefile(
    "${path.root}/../application/user_data.sh.tftpl",
    {
      app_source_base64   = var.app_source_base64
      requirements_base64 = var.requirements_base64
      db_secret_arn       = var.db_secret_arn
      aws_region          = var.aws_region
    }
  ))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.name_prefix}-app-instance"
      Tier = "Application"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
