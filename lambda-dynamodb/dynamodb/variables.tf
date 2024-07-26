variable "region" {
  description = "The AWS region to deploy the DynamoDB table"
  type        = string
  default     = "eu-central-1"
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "example-table"
}

variable "hash_key" {
  description = "The hash key for the DynamoDB table"
  type        = string
  default     = "id"
}
