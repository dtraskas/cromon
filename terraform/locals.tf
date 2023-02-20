locals {
  account_id      = data.aws_caller_identity.current.account_id
  region          = data.aws_region.current.name
  vpc_id          = data.aws_vpc.default_vpc.id
  lambda_src_path = "${path.module}/../src/lambdas"
}
