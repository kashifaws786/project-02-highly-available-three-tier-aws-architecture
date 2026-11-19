
# Monitor application EC2 instances through the Auto Scaling Group.

resource "aws_cloudwatch_metric_alarm" "ec2_cpu_high" {
  alarm_name          = "${var.name_prefix}-ec2-high-cpu"
  alarm_description   = "EC2 average CPU utilization is above 80%"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }

  treat_missing_data = "notBreaching"
}

# Monitor the Application Load Balancer for unhealthy targets.

resource "aws_cloudwatch_metric_alarm" "alb_unhealthy_hosts" {
  alarm_name          = "${var.name_prefix}-alb-unhealthy-hosts"
  alarm_description   = "The Application Load Balancer has unhealthy targets"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  statistic           = "Maximum"
  threshold           = 0

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.target_group_arn_suffix
  }

  treat_missing_data = "notBreaching"
}

# Monitor RDS database CPU utilization.

resource "aws_cloudwatch_metric_alarm" "rds_cpu_high" {
  alarm_name          = "${var.name_prefix}-rds-high-cpu"
  alarm_description   = "RDS database CPU utilization is above 80%"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }

  treat_missing_data = "notBreaching"
}
