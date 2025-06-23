variable "function_name" {
  description = "The name for the Lambda function"
  type        = string
}

variable "handler" {
  description = "The function entrypoint in your code"
  type        = string
  default     = "index.handler"
}

variable "runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
  default     = "python3.9"
}

variable "source_paths" {
  description = "List of local file paths to include in the Lambda package"
  type        = list(string)
}

variable "environment_variables" {
  description = "Map of environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "timeout" {
  description = "Timeout in seconds for the Lambda function"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda can use"
  type        = number
  default     = 128
}

variable "publish" {
  description = "Whether to publish a new Lambda version on changes"
  type        = bool
  default     = false
}

variable "role_name" {
  description = "Name of the IAM role to create for the Lambda function"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}