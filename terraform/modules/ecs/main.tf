# ECS cluster and services
resource "aws_ecs_cluster" "main" {
  name = "${var.customer}-${var.project}-ecs-cluster-${var.environment}"
}

# Task definition for Patient Service
resource "aws_ecs_task_definition" "patient" {
  family                   = "${var.customer}-${var.project}-patient-service-${var.environment}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = var.execution_role_arn
  container_definitions = jsonencode([{
    name  = "patient-service"
    image = var.patient_image
    portMappings = [{
      containerPort = var.patient_container_port
      hostPort      = var.patient_container_port
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = var.patient_log_group_name
        awslogs-region        = var.region
        awslogs-stream-prefix = "patient"
      }
    }
  }])
}

# Task definition for Appointment Service
resource "aws_ecs_task_definition" "appointment" {
  family                   = "${var.customer}-${var.project}-appointment-service-${var.environment}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([{
    name  = "appointment-service"
    image = var.appointment_image
    portMappings = [{
      containerPort = var.appointment_container_port
      hostPort      = var.appointment_container_port
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = var.appointment_log_group_name
        awslogs-region        = var.region
        awslogs-stream-prefix = "appointment"
      }
    }
  }])
}

# Target group for Patient Service
resource "aws_lb_target_group" "patient" {
  name        = "${var.customer}-${var.project}-patient-tg-${var.environment}"
  port        = var.patient_container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    path = "/health"
  }
}

# Target group for Appointment Service
resource "aws_lb_target_group" "appointment" {
  name        = "${var.customer}-${var.project}-appointment-tg-${var.environment}"
  port        = var.appointment_container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    path = "/health"
  }
}

# ECS Service for Patient Service
resource "aws_ecs_service" "patient" {
  name            = "${var.customer}-${var.project}-patient-service-${var.environment}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.patient.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [var.private_subnet]
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.patient.arn
    container_name   = "patient-service"
    container_port   = var.patient_container_port
  }
}

# ECS Service for Appointment Service
resource "aws_ecs_service" "appointment" {
  name            = "${var.customer}-${var.project}-appointment-service-${var.environment}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.appointment.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [var.private_subnet]
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.appointment.arn
    container_name   = "appointment-service"
    container_port   = var.appointment_container_port
  }
}
