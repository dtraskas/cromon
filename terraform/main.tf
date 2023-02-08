terraform {
  backend "s3" {
    bucket         = "${var.account_name}-${var.region}-terraform-remote-state"
    key            = "cromon/terraform.tfstate"
    region         = var.region
    dynamodb_table = "tf-state-dynamodb-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/${var.account_name}-role-${var.aws_role}"
  }
}