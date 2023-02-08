terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }

  backend "s3" {
    bucket         = "${var.account_name}-terraform-remote-state"
    key            = "cromon/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-state-dynamodb-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/${var.account_name}-role-${var.aws_role}"
  }
}

resource "aws_s3_bucket" "stg" {
  bucket = "${var.environment}-test"

  force_destroy = true
}