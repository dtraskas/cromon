locals {
  default_tags = jsondecode(file("${path.module}/../tags/defaults.json"))
  table_name   = "${var.application}-${var.environment}-${var.table_name}"
}