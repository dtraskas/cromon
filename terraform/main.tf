# Create an IAM execution role for the Lambda function.
module "run_test_role" {
  source = "./modules/lambda_role"

  name_suffix = "run-test-role"
  description = "Stub IAM role for the lambda."

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

module "cromon-api" {
  source = "./modules/lambda"

  name_suffix = "cromon-api"
  description = "A Lambda function serving the cromon API."

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
}