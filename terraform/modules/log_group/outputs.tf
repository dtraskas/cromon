output "log_arn" {
  description = "The ARN of the log group."
  value       = aws_cloudwatch_log_group.logz.arn
}

output "log_name" {
  description = "The ARN of the log group."
  value       = aws_cloudwatch_log_group.logz.name
}