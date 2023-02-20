locals {
  default_tags = jsondecode(file("${path.module}/../tags/defaults.json"))
  lambda_name  = "${var.account_name}-${var.application}-${var.name_suffix}"
}