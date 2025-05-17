variable "region" {
  type        = string
  description = "AWS region"
}

variable "cidr_block" {
  type = string
}

variable "pub_sub_cidr" {
  type        = string
  description = "public subnet"
}

variable "pri_sub_cidr" {
  type        = string
  description = "private subnet"
}

variable "public_az" {
  type = string
}

variable "private_az" {
  type = string
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
