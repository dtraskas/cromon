output "arn" {
  description = "The ARN of the dynamodb table"
  value       = aws_dynamodb_table.basic-dynamodb-table.arn
  sensitive   = true
}

output "table_name" {
  description = "The name of the dynamodb table"
  value       = aws_dynamodb_table.basic-dynamodb-table.name
}