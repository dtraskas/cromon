variable "default_tags" {
  description = "Tags to be applied to resources."
  type        = map(string)
  default     = {}
}

variable "application" {
  description = "The name of the app."
  type        = string
}

variable "account_name" {
  description = "The AWS account name."
  type        = string
}

variable "account_id" {
  description = "The AWS account ID."
  type        = string

  validation {
    condition     = length(var.account_id) == 12
    error_message = "The account_id must be 12 characters long."
  }

  validation {
    condition     = can(tonumber(var.account_id))
    error_message = "The account_id must be a number."
  }
}

variable "description" {
  description = "What is logged by the log group."
  type        = string
  default     = "Just a log group."
}