// Outputs for consumption by other modules or end users

output "api_invoke_url" {
  description = "Invoke URL for the API Gateway"
  value       = "${aws_api_gateway_deployment.this.invoke_url}/${var.api_stage_name}"
}

output "lambda_function_arn" {
  description = "ARN of the deployed Lambda function"
  value       = module.simple_lambda.lambda_function_arn
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = module.dynamodb_table.name
}  