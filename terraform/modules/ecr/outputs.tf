output "patient_repository_url" {
  value = aws_ecr_repository.patient_ecr.repository_url
}

output "appointment_repository_url" {
  value = aws_ecr_repository.appointment_ecr.repository_url
}
