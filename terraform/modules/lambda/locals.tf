locals {
  default_tags = jsondecode(file("${path.module}/../tags/defaults.json"))
  lambda_name  = "${var.application}-${var.environment}-${var.name_suffix}"
}