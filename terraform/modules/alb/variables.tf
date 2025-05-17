variable "customer" {}
variable "project" {}
variable "environment" {}
variable "vpc_id" {}
variable "public_subnet_ids" { type = list(string) }
variable "alb_security_group_id" {}
variable "patient_target_group_arn" {}
variable "appointment_target_group_arn" {}
