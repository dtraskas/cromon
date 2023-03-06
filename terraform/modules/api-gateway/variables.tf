variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

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

variable "environment" {
  description = "The environment the infrastructure is deployed to."
  type        = string
}

variable "description" {
  type        = string
  default     = ""
  description = "The description of the REST API "
}

variable "path_parts" {
  type        = string
  default     = ""
  description = "The last path segment of this API resource."
}

variable "deployment_stage" {
  type        = string
  default     = ""
  description = "The name of the stage. If the specified stage already exists, it will be updated to point to the new deployment. If the stage does not exist, a new one will be created and point to this deployment."
}

variable "http_methods" {
  type        = string
  default     = ""
  description = "The HTTP Method (GET, POST, PUT, DELETE, HEAD, OPTIONS, ANY)."
}

variable "integration_http_methods" {
  type        = string
  default     = ""
  description = "The integration HTTP method (GET, POST, PUT, DELETE, HEAD, OPTIONs, ANY, PATCH) specifying how API Gateway will interact with the back end. Required if type is AWS, AWS_PROXY, HTTP or HTTP_PROXY. Not all methods are compatible with all AWS integrations. e.g. Lambda function can only be invoked via POST."
}

variable "integration_types" {
  type        = string
  default     = ""
  description = "The integration input's type. Valid values are HTTP (for HTTP backends), MOCK (not calling any real backend), AWS (for AWS services), AWS_PROXY (for Lambda proxy integration) and HTTP_PROXY (for HTTP proxy integration). An HTTP or HTTP_PROXY integration with a connection_type of VPC_LINK is referred to as a private integration and uses a VpcLink to connect API Gateway to a network load balancer of a VPC."
}

variable "lambda_arn" {
  type        = string
  description = "The lambda ARN used to serve the API."
}

variable "lambda_name" {
  type        = string
  description = "The lambda name used to serve the API."
}