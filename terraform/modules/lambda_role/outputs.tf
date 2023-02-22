output "name" {
  description = "The name of the role."
  value       = aws_iam_role.lambda_role.name
}

output "arn" {
  description = "The ARN of the role."
  value       = aws_iam_role.lambda_role.arn
}