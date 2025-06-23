# Simple Lambda Module

This Terraform module deploys an AWS Lambda function with minimal configuration. It packages local source files, sets up a basic execution role, and creates the Lambda function.

## Usage
```hcl
module "simple_lambda" {
  source              = "./modules/lambda"
  function_name       = "my-simple-function"
  handler             = "app.lambda_handler"
  runtime             = "python3.12"
  source_paths        = ["${path.module}/src/index.py", "${path.module}/src/utils.py"]
  environment_variables = {
    ENV = "production"
  }
  timeout             = 60
  memory_size         = 256
  publish             = true
  tags = {
    Project = "Prototype"
  }
}
```

## Inputs

- function_name (string, required): Name of the Lambda function.
- handler (string, optional): Function entrypoint. Default: `index.handler`.
- runtime (string, optional): Lambda runtime. Default: `python3.9`.
- source_paths (list(string), required): List of file paths to include in the package.
- environment_variables (map(string), optional): Environment variables for the function.
- timeout (number, optional): Function timeout in seconds. Default: `30`.
- memory_size (number, optional): Memory in MB. Default: `128`.
- publish (bool, optional): Publish a new version on changes. Default: `false`.
- role_name (string, optional): Name for the generated IAM role. Default: generated.
- tags (map(string), optional): Tags to apply to resources.
- aws_region (string, optional): AWS region. Default: `us-east-1`.

## Outputs

- lambda_function_arn: The ARN of the created Lambda function.
- lambda_function_name: The name of the created Lambda function.
- lambda_function_invoke_arn: The invoke ARN of the Lambda function.
