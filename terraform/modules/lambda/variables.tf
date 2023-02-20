variable "default_tags" {
  description = "Tags to be applied to resources."
  type        = map(string)
  default     = {}
}

variable "name_suffix" {
  description = "The lambda function name suffix."
  type        = string
}

variable "handler" {
  description = "The lambda function handler."
  type        = string
}

variable "description" {
  description = "Purpose of the lambda."
  type        = string
  default     = "Just a lambda."
}

variable "environment" {
  description = "The environment the infrastructure is deployed to."
  type        = string
}

variable "source_path" {
  description = "The path to the directory to zip up."
  type        = string
  default     = null
}

variable "role" {
  description = "The lambda function role ARN."
  type        = string
}

variable "timeout" {
  description = "The lambda function timeout."
  type        = number
  default     = 900
}

variable "memory_size" {
  description = "The amount of memory in MB the lambda can use."
  type        = number
  default     = 128

  validation {
    condition     = var.memory_size > 128 && var.memory_size < 4096
    error_message = "Memory size is outside the lower limit of 128MB and upper limit of 4GB."
  }
}

variable "runtime" {
  description = "The lambda runtime"
  type        = string
  default     = "python3.8"

  validation {
    condition     = contains(["python3.8", "python3.9"], var.runtime)
    error_message = "Only python3.8 and python3.9 are currently supported."
  }
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

# variable "subnets" {
#   description = "List of subnet Ids."
#   type        = list(string)
# }

# variable "security_groups" {
#   description = "List of security groups."
#   type        = list(string)
# }

variable "retries" {
  description = "The maximum number of times retrying the lambda when an exception is raised."
  type        = number
  default     = 3
}