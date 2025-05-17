output "patient_log_group_name" {
  value = aws_cloudwatch_log_group.patient.name
}

output "appointment_log_group_name" {
  value = aws_cloudwatch_log_group.appointment.name
}
