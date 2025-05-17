# Setting up CloudWatch log groups for our services
resource "aws_cloudwatch_log_group" "patient" {
  name = "/ecs/${var.customer}-${var.project}-patient-logs-${var.environment}"
  tags = {
    Name = "${var.customer}-${var.project}-patient-logs-${var.environment}"
  }
}

resource "aws_cloudwatch_log_group" "appointment" {
  name = "/ecs/${var.customer}-${var.project}-appointment-logs-${var.environment}"
  tags = {
    Name = "${var.customer}-${var.project}-appointment-logs-${var.environment}"
  }
}
