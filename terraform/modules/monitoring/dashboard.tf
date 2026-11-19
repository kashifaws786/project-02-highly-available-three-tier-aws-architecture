
# Create a CloudWatch dashboard for the three-tier architecture.

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.name_prefix}-monitoring"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "EC2 CPU Utilization"
          region = var.aws_region
          view   = "timeSeries"
          period = 300

          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "AutoScalingGroupName",
              var.autoscaling_group_name
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "ALB Request Count"
          region = var.aws_region
          view   = "timeSeries"
          period = 300

          metrics = [
            [
              "AWS/ApplicationELB",
              "RequestCount",
              "LoadBalancer",
              var.alb_arn_suffix
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          title  = "ALB Unhealthy Targets"
          region = var.aws_region
          view   = "timeSeries"
          period = 300

          metrics = [
            [
              "AWS/ApplicationELB",
              "UnHealthyHostCount",
              "LoadBalancer",
              var.alb_arn_suffix,
              "TargetGroup",
              var.target_group_arn_suffix
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          title  = "RDS CPU Utilization"
          region = var.aws_region
          view   = "timeSeries"
          period = 300

          metrics = [
            [
              "AWS/RDS",
              "CPUUtilization",
              "DBInstanceIdentifier",
              var.db_instance_id
            ]
          ]
        }
      }
    ]
  })
}
