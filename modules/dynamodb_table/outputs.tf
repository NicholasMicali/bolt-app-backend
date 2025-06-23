output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value       = local.dynamodb_table_arn
}

output "dynamodb_table_id" {
  description = "ID of the DynamoDB table"
  value       = try(
    aws_dynamodb_table.this[0].id,
    aws_dynamodb_table.autoscaled[0].id,
    aws_dynamodb_table.autoscaled_gsi_ignore[0].id,
    ""
  )
}

output "dynamodb_table_stream_arn" {
  description = "The ARN of the Table Stream. Only available when stream_enabled is true"
  value       = var.stream_enabled ? try(
    aws_dynamodb_table.this[0].stream_arn,
    aws_dynamodb_table.autoscaled[0].stream_arn,
    aws_dynamodb_table.autoscaled_gsi_ignore[0].stream_arn,
    ""
  ) : null
}

output "dynamodb_table_stream_label" {
  description = "Table Stream label (ISO 8601). Only available when stream_enabled is true"
  value       = var.stream_enabled ? try(
    aws_dynamodb_table.this[0].stream_label,
    aws_dynamodb_table.autoscaled[0].stream_label,
    aws_dynamodb_table.autoscaled_gsi_ignore[0].stream_label,
    ""
  ) : null
}