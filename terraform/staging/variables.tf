variable "account_name" {
  description = "The name of the AWS account to be used for naming resources"
  type        = string
}

variable "account_id" {
  description = "The 12-digit account ID of the AWS account"
  type        = string

  validation {
    condition     = length(var.account_id) == 12
    error_message = "The account ID must be 12 characters long"
  }

  validation {
    condition     = can(tonumber(var.account_id))
    error_message = "The account ID must be a number"
  }
}

variable "aws_role" {
  description = "The AWS role to run terraform commands"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "The AWS region we are deploying resources into"
  type        = string
  default     = "eu-west-2"
}

variable "environment" {
  description = "This is the environment where the application is deployed"
}