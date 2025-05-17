# Setting up ECR repos to store our Docker images

resource "aws_ecr_repository" "patient_ecr" {
  name                 = "${var.customer}-${var.project}-patient_ecr-${var.environment}"
  image_tag_mutability = "MUTABLE"
  tags = {
    Name = "${var.customer}-${var.project}-patient_ecr-${var.environment}"
  }
}

resource "aws_ecr_repository" "appointment_ecr" {
  name                 = "${var.customer}-${var.project}-appointment_ecr-${var.environment}"
  image_tag_mutability = "MUTABLE"
  tags = {
    Name = "${var.customer}-${var.project}-appointment_ecr-${var.environment}"
  }
}
