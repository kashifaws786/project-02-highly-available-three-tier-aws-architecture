
# Create an Auto Scaling Group for the application EC2 instances.

resource "aws_autoscaling_group" "app" {
  name = "${var.name_prefix}-app-asg"

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  vpc_zone_identifier = var.app_subnet_ids

  target_group_arns = [
    aws_lb_target_group.app.arn
  ]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.app.id
    version = aws_launch_template.app.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-app-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Tier"
    value               = "Application"
    propagate_at_launch = true
  }

  depends_on = [
    aws_lb_listener.http,
    aws_iam_role_policy_attachment.ssm,
    aws_iam_role_policy.database_secret_access
  ]
}
