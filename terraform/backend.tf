terraform {
  backend "s3" {
    bucket         = "terraform-remote-state"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-state-dynamodb-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.30.0"
    }
  }
}