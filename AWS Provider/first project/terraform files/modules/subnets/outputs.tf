output "frontend_subnet_id" {
  value = aws_subnet.frontend.id
}

output "backend_subnet_id" {
  value = aws_subnet.backend.id
}
