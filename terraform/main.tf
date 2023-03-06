# Create an IAM execution role for the Lambda function.
module "run_test_role" {
  source = "./modules/lambda_role"

  name_suffix  = "run-test-role"
  description  = "Stub IAM role for the lambda."
  account_id   = local.account_id
  account_name = var.account_name
  application  = var.application
  environment  = var.environment

  policy = templatefile("./iam_policies/lambda_generic.json",
    {
      ACCOUNT_ID : data.aws_caller_identity.current.account_id
      REGION : data.aws_region.current.name
  })
}

# Create the cromon API lambda that serves as the API server
module "cromon_api" {
  source = "./modules/lambda"

  name_suffix  = "cromon-api"
  description  = "A Lambda function serving the cromon API."
  account_id   = local.account_id
  account_name = var.account_name
  application  = var.application
  environment  = var.environment

  source_path = "${local.lambda_src_path}/cromon_api"
  handler     = "app.handler"
  runtime     = "python3.8"

  role        = module.run_test_role.arn
  memory_size = 256
  timeout     = 30
  default_tags = {
    purpose = "cronjob monitoring"
  }
}

# Set up of API Gateway

# resource "aws_api_gateway_rest_api" "apiLambda" {
#   name = "CromonAPI"
# }

# resource "aws_api_gateway_resource" "proxy" {
#   rest_api_id = aws_api_gateway_rest_api.apiLambda.id
#   parent_id   = aws_api_gateway_rest_api.apiLambda.root_resource_id
#   path_part   = "{proxy+}"
# }

# resource "aws_api_gateway_method" "proxyMethod" {
#   rest_api_id   = aws_api_gateway_rest_api.apiLambda.id
#   resource_id   = aws_api_gateway_resource.proxy.id
#   http_method   = "ANY"
#   authorization = "NONE"
# }

# resource "aws_api_gateway_integration" "lambda" {
#   rest_api_id = aws_api_gateway_rest_api.apiLambda.id
#   resource_id = aws_api_gateway_method.proxyMethod.resource_id
#   http_method = aws_api_gateway_method.proxyMethod.http_method

#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = module.cromon_api.invoke_arn
# }

# resource "aws_api_gateway_method" "proxy_root" {
#   rest_api_id   = aws_api_gateway_rest_api.apiLambda.id
#   resource_id   = aws_api_gateway_rest_api.apiLambda.root_resource_id
#   http_method   = "ANY"
#   authorization = "NONE"
# }

# resource "aws_api_gateway_integration" "lambda_root" {
#   rest_api_id = aws_api_gateway_rest_api.apiLambda.id
#   resource_id = aws_api_gateway_method.proxy_root.resource_id
#   http_method = aws_api_gateway_method.proxy_root.http_method

#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = module.cromon_api.invoke_arn
# }

# resource "aws_api_gateway_deployment" "apideploy" {
#   depends_on = [
#     aws_api_gateway_integration.lambda,
#     aws_api_gateway_integration.lambda_root
#   ]
#   rest_api_id = aws_api_gateway_rest_api.apiLambda.id
#   stage_name  = "deploy"
# }

# resource "aws_lambda_permission" "apigw" {
#   statement_id  = "AllowAPIGatewayInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = module.cromon_api.name
#   principal     = "apigateway.amazonaws.com"

#   # The "/*/*" portion grants access from any method on any resource
#   # within the API Gateway REST API.
#   source_arn = "${aws_api_gateway_rest_api.apiLambda.execution_arn}/*/*"
# }


# Create the API Gateway serving Cromon requests
module "api_gateway" {
  source = "./modules/api-gateway"

  name         = "CromonAPI"
  description  = "The Cromon API for monitoring cronjobs"
  account_id   = local.account_id
  account_name = var.account_name
  application  = var.application
  environment  = var.environment

  path_parts               = "{proxy+}"
  http_methods             = "ANY"
  integration_types        = "AWS_PROXY"
  integration_http_methods = "POST"
  lambda_name              = module.cromon_api.name
  lambda_arn               = module.cromon_api.invoke_arn
  deployment_stage         = "deploy" 
}