// Global variables for the Bolt app backend

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {
    Project     = "bolt-app-backend"
    Environment = var.environment
  }
}

// Lambda module inputs
variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "bolt-backend-fn"
}

variable "lambda_handler" {
  description = "Lambda function handler"
  type        = string
  default     = "app.lambda_handler"
}

variable "lambda_runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "python3.12"
}

variable "lambda_source_paths" {
  description = "List of local source files for Lambda"
  type        = list(string)
  default     = [
    "src/app.py"
  ]
}

variable "lambda_timeout" {
  description = "Lambda function timeout in seconds"
  type        = number
  default     = 30
}

variable "lambda_memory_size" {
  description = "Lambda function memory size in MB"
  type        = number
  default     = 256
}

// DynamoDB module inputs
variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "bolt-app-store"
}

variable "dynamodb_hash_key" {
  description = "Partition key for DynamoDB table"
  type        = string
  default     = "id"
}

variable "dynamodb_billing_mode" {
  description = "Billing mode for DynamoDB"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "dynamodb_attributes" {
  description = "Attribute definitions for DynamoDB table"
  type        = list(object({ name = string, type = string }))
  default     = [
    { name = "id", type = "S" }
  ]
}

// API Gateway inputs
variable "api_name" {
  description = "Name of the API Gateway REST API"
  type        = string
  default     = "bolt-backend-api"
}

variable "api_stage_name" {
  description = "Deployment stage name for API Gateway"
  type        = string
  default     = "${var.environment}"
}
