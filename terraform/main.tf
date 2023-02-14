# resource "aws_s3_bucket" "app_bucket" {
#   bucket        = "${var.account_id}-${var.env}-app"
#   force_destroy = true
# }