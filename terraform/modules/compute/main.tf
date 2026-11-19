
# Create an Application Load Balancer across both public subnets.

resource "aws_lb" "main" {
  name               = "${var.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [var.alb_security_group_id]
  subnets         = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "${var.name_prefix}-alb"
  }
}

# Create a target group for the EC2 application instances.

resource "aws_lb_target_group" "app" {
  name        = "${var.name_prefix}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 3
    interval            = 30
    timeout             = 5
    path                = "/health"
    matcher             = "200"
  }

  tags = {
    Name = "${var.name_prefix}-tg"
  }
}

# Create an HTTP listener on the Application Load Balancer.

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
