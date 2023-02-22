terraform {
  backend "s3" {
    bucket         = "terraform-remote-state"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-state-dynamodb-lock"
    encrypt        = true
  }

  required_providers {
    archive = "~> 2.0.0"
    aws = "~> 4.0"
    null = "~> 3.0.0"
    random = "~> 3.0.0"
  }
}