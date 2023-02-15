# resource "aws_s3_bucket" "app_bucket" {
#   bucket = "${var.account_id}-${var.env}-app"
#   tags = {
#     Owner       = "cromon"
#     Environment = "${var.env}"
#   }
# }

# resource "aws_s3_bucket_public_access_block" "app_bucket" {
#   bucket                  = aws_s3_bucket.app_bucket.id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }