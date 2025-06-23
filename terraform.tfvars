// terraform.tfvars for local development
aws_region           = "us-east-1"
environment          = "dev"
// Lambda settings
lambda_function_name = "bolt-backend-fn"
lambda_source_paths  = ["src/app.py"]

// DynamoDB settings
dynamodb_table_name  = "bolt-backend-store"
// Table with simple string id

tags = {
  Project     = "bolt-app-backend"
  Environment = "dev"
}  