output "id" {
  value       = aws_api_gateway_rest_api.apiLambda.id
  description = "The ID of the REST API."
}

output "execution_arn" {
  value       = aws_api_gateway_rest_api.apiLambda.execution_arn
  description = "The Execution ARN of the REST API."
}