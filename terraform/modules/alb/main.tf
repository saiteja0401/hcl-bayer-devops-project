# Setting up the ALB to route traffic to our services
resource "aws_lb" "main" {
  name               = "${var.customer}-${var.project}-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.public_subnet_ids
  tags = {
    Name = "${var.customer}-${var.project}-alb-${var.environment}"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  # Default action returns 404 if no rules match
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: Not Found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "patient" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = var.patient_target_group_arn
  }
  condition {
    path_pattern {
      values = ["/patients/*"]
    }
  }
}

resource "aws_lb_listener_rule" "appointment" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 200
  action {
    type             = "forward"
    target_group_arn = var.appointment_target_group_arn
  }
  condition {
    path_pattern {
      values = ["/appointments/*"]
    }
  }
}
