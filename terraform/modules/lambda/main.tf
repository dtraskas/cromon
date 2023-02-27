/**
*   Lambda function
*   
*   Creates a lambda function connected to a VPC
*
*   The function is encrypted by default, has the default tags,
*   log groups and KMS keys all created as part of this module.
*/

module "log_group" {
  source = "../log_group"

  name         = "/aws/lambda/${local.lambda_name}"
  account_name = var.account_name
  application  = var.application
  environment  = var.environment
}

# Compute the source code hash, only taking into
# consideration the actual application code files
# and the dependencies list.
resource "random_uuid" "lambda_src_hash" {
  keepers = {
    for filename in setunion(
      fileset(var.source_path, "*.py"),
      fileset(var.source_path, "requirements.txt")
    ) :
    filename => filemd5("${var.source_path}/${filename}")
  }
}

# Automatically install dependencies to be packaged
# with the Lambda function as required by AWS Lambda:
# https://docs.aws.amazon.com/lambda/latest/dg/python-package.html#python-package-dependencies
resource "null_resource" "install_dependencies" {
  provisioner "local-exec" {
    command = <<-EOT
      rm -rf ${path.module}/.venv && rm -rf ${path.module}/.pkg && rm -rf ${path.module}/.tmp
      python3 -m venv ${path.module}/.venv
      source ${path.module}/.venv/bin/activate
      pip install -r ${var.source_path}/requirements.txt --upgrade
      deactivate
      cp -a ${path.module}/.venv/lib/${var.runtime}/site-packages/. ${path.module}/.pkg
      cp -a ${var.source_path}/ ${path.module}/.pkg
    EOT
  }

  # Only re-run this if the dependencies or their versions
  # have changed since the last deployment with Terraform
  # triggers = {
  #   dependencies_versions = filemd5("${var.source_path}/requirements.txt")
  # }
  triggers = {
    always_run = timestamp()
  }
}

# Create an archive form the Lambda source code,
# filtering out unneeded files.
data "archive_file" "lambda_source_package" {
  depends_on  = [null_resource.install_dependencies]
  type        = "zip"
  source_dir  = "${path.module}/.pkg"
  output_path = "${path.module}/.tmp/${random_uuid.lambda_src_hash.result}.zip"

  excludes = [
    "__pycache__",
    "tests"
  ]
}

# Deploy the Lambda function to AWS
resource "aws_lambda_function" "lambda_function" {

  function_name = local.lambda_name
  description   = var.description

  role        = var.role
  runtime     = var.runtime
  memory_size = var.memory_size
  timeout     = var.timeout
  handler     = var.handler

  filename         = data.archive_file.lambda_source_package.output_path
  source_code_hash = data.archive_file.lambda_source_package.output_base64sha256

  lifecycle {
    # Terraform will any ignore changes to the
    # environment variables after the first deploy.
    ignore_changes = [environment]
  }

  tags = merge(
    local.default_tags,
    {
      application = var.application
      environment = var.environment
    }
  )
}

# Cleanup after installing
resource "null_resource" "cleanup" {
  depends_on = [
    aws_lambda_function.lambda_function
  ]
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "rm -rf ${path.module}/.venv && rm -rf ${path.module}/.pkg && rm -rf ${path.module}/.tmp"
  }
}