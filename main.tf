// Instantiate Lambda via module
module "simple_lambda" {
  source                = "./modules/lambda"
  function_name         = var.lambda_function_name
  handler               = var.lambda_handler
  runtime               = var.lambda_runtime
  source_paths          = var.lambda_source_paths
  environment_variables = { ENV = var.environment }
  timeout               = var.lambda_timeout
  memory_size           = var.lambda_memory_size
  publish               = true
  role_name             = "${var.lambda_function_name}-role"
  tags                  = var.tags
}

// Instantiate DynamoDB table via module
data "aws_region" "current" {}
module "dynamodb_table" {
  source                    = "./modules/dynamodb_table"
  name                      = var.dynamodb_table_name
  hash_key                  = var.dynamodb_hash_key
  billing_mode              = var.dynamodb_billing_mode
  attributes                = var.dynamodb_attributes
  autoscaling_enabled       = false
  create_table              = true
  tags                      = var.tags
}

// API Gateway REST API
data "aws_iam_policy_document" "lambda_invoke_api_gateway" {
  statement {
    actions   = ["lambda:InvokeFunction"]
    resources = [module.simple_lambda.lambda_function_invoke_arn]
    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

resource "aws_api_gateway_rest_api" "this" {
  name        = var.api_name
  description = "Bolt app backend API"
  tags        = var.tags
}

resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "get_items" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_get" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.api_resource.id
  http_method             = aws_api_gateway_method.get_items.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.simple_lambda.lambda_function_invoke_arn
}

// Grant permission for API Gateway to invoke the Lambda
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.simple_lambda.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.get_items.http_method}${aws_api_gateway_resource.api_resource.path}"
}

// Deployment and Stage
resource "aws_api_gateway_deployment" "this" {
  depends_on = [aws_api_gateway_integration.lambda_get]
  rest_api_id = aws_api_gateway_rest_api.this.id
  description = "Deployment for commit"
}

resource "aws_api_gateway_stage" "this" {
  rest_api_id    = aws_api_gateway_rest_api.this.id
  stage_name     = var.api_stage_name
  deployment_id  = aws_api_gateway_deployment.this.id
  description    = "${var.environment} stage"
  xray_tracing_enabled = false
}
