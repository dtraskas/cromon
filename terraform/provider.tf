provider "aws" {
  region = "${var.region}"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }

  backend "s3" {
    bucket         = "${var.account_name}-terraform-remote-state"
    key            = "cromon/${var.env}/terraform.tfstate"
    region         = "${var.region}"
    dynamodb_table = "${var.account_name}-tf-state-dynamodb-lock"
    encrypt        = true
  }
}