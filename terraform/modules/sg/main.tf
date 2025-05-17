# Security group for the ALB
resource "aws_security_group" "alb" {
  name        = "${var.customer}-${var.project}-alb-sg-${var.environment}"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.customer}-${var.project}-alb-sg-${var.environment}"
  }
}

# Security group for ECS tasks
resource "aws_security_group" "ecs" {
  name        = "${var.customer}-${var.project}-ecs-sg-${var.environment}"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id
  ingress {
    description     = "Allow TCP on port 3000"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id] # Corrected from cidr_blocks
  }
  ingress {
    description     = "Allow TCP on port 3001"
    from_port       = 3001
    to_port         = 3001
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id] # Corrected from cidr_blocks
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.customer}-${var.project}-ecs-sg-${var.environment}"
  }
}
