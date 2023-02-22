variable "default_tags" {
  description = "Tags to be applied to resources."
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "The name of the log group."
  type        = string
}

variable "application" {
  description = "The name of the app."
  type        = string
}

variable "account_name" {
  description = "The AWS account name."
  type        = string
}

variable "description" {
  description = "What is logged by the log group."
  type        = string
  default     = "Just a log group."
}

variable "environment" {
  description = "The environment the infrastructure is deployed to."
  type        = string
}

variable "log_retention" {
  description = "The log group retention in days"
  type        = number
  default     = 7
}