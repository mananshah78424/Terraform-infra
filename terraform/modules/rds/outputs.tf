output "db_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.this.endpoint
}

output "db_identifier" {
  description = "The RDS instance identifier"
  value       = aws_db_instance.this.id
}