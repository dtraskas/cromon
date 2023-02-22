locals {
  default_tags = jsondecode(file("${path.module}/../tags/defaults.json"))
  role_name    = "${var.application}-${var.environment}-${var.name_suffix}"
}