variable "create_table" {
  description = "Controls if DynamoDB table and associated resources are created"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = null
}

variable "attributes" {
  description = "List of nested attribute definitions. Required for hash_key and range_key attributes"
  type        = list(map(string))
  default     = []
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key"
  type        = string
  default     = null
}

variable "range_key" {
  description = "The attribute to use as the range (sort) key"
  type        = string
  default     = null
}

variable "billing_mode" {
  description = "PROVISIONED or PAY_PER_REQUEST"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "write_capacity" {
  description = "The number of write units for this table (PROVISIONED mode)"
  type        = number
  default     = null
}

variable "read_capacity" {
  description = "The number of read units for this table (PROVISIONED mode)"
  type        = number
  default     = null
}

variable "point_in_time_recovery_enabled" {
  description = "Enable point-in-time recovery"
  type        = bool
  default     = false
}

variable "ttl_enabled" {
  description = "Enable Time To Live (TTL)"
  type        = bool
  default     = false
}

variable "ttl_attribute_name" {
  description = "The name of the attribute for TTL timestamp"
  type        = string
  default     = ""
}

variable "global_secondary_indexes" {
  description = "List of Global Secondary Index definitions"
  type        = any
  default     = []
}

variable "local_secondary_indexes" {
  description = "List of Local Secondary Index definitions"
  type        = any
  default     = []
}

variable "replica_regions" {
  description = "List of replica region blocks for global tables"
  type        = any
  default     = []
}

variable "stream_enabled" {
  description = "Enable DynamoDB Streams"
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "View type for Streams: KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES"
  type        = string
  default     = null
}

variable "server_side_encryption_enabled" {
  description = "Enable encryption at rest with KMS"
  type        = bool
  default     = false
}

variable "server_side_encryption_kms_key_arn" {
  description = "ARN of the KMS key to use for encryption"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the table and its resources"
  type        = map(string)
  default     = {}
}

variable "timeouts" {
  description = "Timeouts for create, update, and delete operations"
  type        = map(string)
  default     = {
    create = "10m"
    update = "60m"
    delete = "10m"
  }
}

variable "autoscaling_enabled" {
  description = "Enable read/write autoscaling"
  type        = bool
  default     = false
}

variable "autoscaling_defaults" {
  description = "Default autoscaling settings"
  type        = map(string)
  default     = {
    scale_in_cooldown  = 0
    scale_out_cooldown = 0
    target_value       = 70
  }
}

variable "autoscaling_read" {
  description = "Autoscaling settings for read capacity"
  type        = map(string)
  default     = {}
}

variable "autoscaling_write" {
  description = "Autoscaling settings for write capacity"
  type        = map(string)
  default     = {}
}

variable "autoscaling_indexes" {
  description = "Autoscaling settings for GSIs"
  type        = map(map(string))
  default     = {}
}

variable "table_class" {
  description = "STANDARD or STANDARD_INFREQUENT_ACCESS"
  type        = string
  default     = null
}

variable "deletion_protection_enabled" {
  description = "Enable deletion protection on the table"
  type        = bool
  default     = null
}

variable "import_table" {
  description = "Configuration block for importing data from S3"
  type        = any
  default     = {}
}

variable "ignore_changes_global_secondary_index" {
  description = "Ignore lifecycle changes to GSIs when autoscaling enabled"
  type        = bool
  default     = false
}

variable "on_demand_throughput" {
  description = "On-demand throughput settings"
  type        = any
  default     = {}
}

variable "restore_date_time" {
  description = "Point in time to restore"
  type        = string
  default     = null
}

variable "restore_source_name" {
  description = "Source table name for restore"
  type        = string
  default     = null
}

variable "restore_source_table_arn" {
  description = "Source table ARN for cross-region restore"
  type        = string
  default     = null
}

variable "restore_to_latest_time" {
  description = "Restore to latest recovery point"
  type        = bool
  default     = null
}

variable "resource_policy" {
  description = "JSON definition of a resource-based policy"
  type        = string
  default     = null
}
