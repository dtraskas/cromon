resource "aws_s3_bucket" "stg" {
  bucket        = "${var.env}-test"
  force_destroy = true
}