# Terraform AWS DynamoDB Table Module

This module creates a DynamoDB table with flexible configuration options including:

- Provisioned or on-demand billing modes
- Optional auto scaling for read/write capacity
- Server-side encryption with AWS KMS
- Point-in-time recovery
- Time-to-live (TTL)
- Streams (optional views)
- Global and local secondary indexes
- Global table replicas across regions
- Import of data from S3 (JSON or CSV)
- Resource-based policy attachment

## Usage
```hcl
module "dynamodb_table" {
  source  = "./modules/dynamodb_table"

  name           = "my-table"
  hash_key       = "id"
  range_key      = "timestamp"

  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5

  autoscaling_enabled                   = true
  autoscaling_read = { max_capacity = 10 }
  autoscaling_write = { max_capacity = 10 }

  attributes = [
    { name = "id",        type = "S" },
    { name = "timestamp", type = "N" },
  ]

  global_secondary_indexes = [
    {
      name               = "GSI1"
      hash_key           = "timestamp"
      projection_type    = "ALL"
      write_capacity     = 5
      read_capacity      = 5
    }
  ]

  tags = {
    Environment = "staging"
  }
}
```

See `variables.tf` for all available inputs and default values.
<!-- END_TF_DOCS -->
