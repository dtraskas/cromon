locals {
  default_tags = jsondecode(file("${path.module}/../tags/defaults.json"))
  role_name    = "${var.account_name}-${var.application}-${var.name_suffix}"
}