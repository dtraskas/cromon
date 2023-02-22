output "arn" {
  description = "The ARN of the lambda."
  value       = aws_lambda_function.lambda_function.arn
}

output "name" {
  description = "The name of the lambda."
  value       = aws_lambda_function.lambda_function.function_name
}

# output "log_arn" {
#   description = "The ARN of the log group."
#   value       = module.log_group.log_arn
# }

output "invoke_arn" {
  description = "The invoke ARN of the lambda"
  value       = aws_lambda_function.lambda_function.invoke_arn
}