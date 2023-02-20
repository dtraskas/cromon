output "role_arn" {
  description = "The ARN of the role."
  value       = aws_iam_role.lambda_role.arn
}