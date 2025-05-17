variable "region" {
  type        = string
  description = "AWS region"
}

variable "cidr_block" {
  type = string
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of private subnet CIDR blocks"
}

variable "public_azs" {
  type        = list(string)
  description = "List of public subnet Availability Zones"
}

variable "private_azs" {
  type        = list(string)
  description = "List of private subnet Availability Zones"
}

variable "environment" {
  description = "The environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = var.environment == terraform.workspace
    error_message = "The environment variable must match the workspace name."
  }
}

variable "customer" {
  type = string
}

variable "project" {
  type = string
}

variable "task_cpu" {
  type = number
}

variable "task_memory" {
  type = number
}

variable "patient_image_tag" {
  type        = string
  description = "Tag for patient service image"
}

variable "appointment_image_tag" {
  type        = string
  description = "Tag for appointment service image"
}

variable "patient_container_port" {
  type = number
}

variable "appointment_container_port" {
  type = number
}

variable "desired_count" {
  type = number
}
