locals {
  default_tags = jsondecode(file("${path.module}/../tags/defaults.json"))
}