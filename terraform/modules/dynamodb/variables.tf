variable "default_tags" {
  description = "Tags to be applied to resources."
  type        = map(string)
  default     = {}
}

variable "table_name" {
  description = "The dynamodb table name."
  type        = string
}

variable "read_capacity" {
  description = "The dynamodb table read capacity."
  type        = number
  default     = 5
}

variable "write_capacity" {
  description = "The dynamodb table write capacity."
  type        = number
  default     = 5
}

variable "hash_key" {
  description = "The dynamodb table partition key."
  type        = string
}

variable "hash_key_type" {
  description = "The partition key type."
  type        = string
}

variable "sort_key" {
  description = "The dynamodb sort key."
  type        = string
  default     = ""
}

variable "backup_enabled" {
  description = "The dynamodb point in time recovery setting."
  type        = bool
  default     = true
}

variable "attributes" {
  description = "List of nested attribute definitions."
  type        = list(map(string))
  default     = []
}

variable "description" {
  description = "Purpose of the dynamodb table."
  type        = string
  default     = "Just a lambda."
}

variable "environment" {
  description = "The environment the infrastructure is deployed to."
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