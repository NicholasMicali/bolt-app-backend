// IAM role for Lambda
data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

// Package local code into a zip
data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/lambda_package.zip"
  source { 
    for_each = var.source_paths
    content  = file(var.source_paths[each.key])
    filename = basename(var.source_paths[each.key])
  }
}

// Lambda function
esource "aws_lambda_function" "this" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = var.function_name
  role             = aws_iam_role.this.arn
  handler          = var.handler
  runtime          = var.runtime
  publish          = var.publish

  environment {
    variables = var.environment_variables
  }

  timeout          = var.timeout
  memory_size      = var.memory_size

  tags             = var.tags

  lifecycle {
    ignore_changes = [filename]
  }
}
