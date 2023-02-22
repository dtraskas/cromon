locals {
  account_id      = data.aws_caller_identity.current.account_id
  region          = data.aws_region.current.name
  lambda_src_path = "${path.module}/../src/lambdas"
}
