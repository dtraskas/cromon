resource "aws_s3_bucket_public_access_block" "app_bucket" {
  bucket        = "${var.account_id}-${var.env}-app"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  force_destroy = true
  tags = {
    Owner       = "cromon"
    Environment = "${var.env}"
  }
}