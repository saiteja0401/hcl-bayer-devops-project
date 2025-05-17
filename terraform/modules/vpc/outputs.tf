output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

# output "ecs_security_group" {
#   value = aws_security_group.ecs_tasks.id
# }
