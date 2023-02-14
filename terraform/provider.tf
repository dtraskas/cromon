provider "aws" {
  region = "eu-west-2"
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
    key            = "cromon/environments/${var.env}/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-state-dynamodb-lock"
    encrypt        = true
  }
}