# Create an IAM execution role for the Lambda function.
module "run_test_role" {
  source = "./modules/lambda_role"

  name_suffix = "run-test-role"
  description = "Stub IAM role for the lambda."

  account_id   = local.account_id
  account_name = var.account_name
  application  = var.application

  policy = templatefile("./policies/lambda_generic.json",
    {
      ACCOUNT_ID : data.aws_caller_identity.current.account_id
      REGION : data.aws_region.current.name
  })
}

module "run_test" {
  source = "./modules/lambda"

  name_suffix = "run-test"
  description = "Just a stub Lambda function logging multidimensional arrays full of zeros."

  account_id   = local.account_id
  account_name = var.account_name
  application  = var.application

  source_path = "${local.lambda_src_path}/run_test"
  handler     = "app.lambda_handler"
  # environment = var.environment
  runtime = "python3.8"

  role        = module.run_test_role.role_arn
  memory_size = 256
  timeout     = 30
}