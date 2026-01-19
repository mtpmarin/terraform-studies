output "endpoint" {
  value = aws_db_instance.database.endpoint
}

output "db_instance_id" {
  value = aws_db_instance.database.id
}

output "db_address" {
  value = aws_db_instance.database.address
}
