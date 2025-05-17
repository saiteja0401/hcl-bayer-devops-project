output "patient_target_group_arn" {
  value = aws_lb_target_group.patient.arn
}

output "appointment_target_group_arn" {
  value = aws_lb_target_group.appointment.arn
}
