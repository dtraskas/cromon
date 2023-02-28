resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = local.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  range_key      = var.sort_key

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  point_in_time_recovery {
    enabled = var.backup_enabled
  }

  tags = merge(
    local.default_tags,
    {
      application = var.application
      environment = var.environment
    },
    var.default_tags
  )
}