variable "region" {}
variable "customer" {}
variable "project" {}
variable "environment" {}
variable "vpc_id" {}
variable "private_subnet_ids" { type = list(string) }

variable "task_cpu" {}
variable "task_memory" {}
variable "patient_container_port" {}
variable "appointment_container_port" {}
variable "desired_count" {}

variable "patient_image" {}
variable "appointment_image" {}

variable "execution_role_arn" {}
variable "alb_security_group_id" {}
variable "ecs_security_group_id" {}

variable "patient_log_group_name" {}
variable "appointment_log_group_name" {}
