variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket for static website hosting"
  type        = string
}

variable "terraform_state_bucket" {
  description = "S3 bucket name to store Terraform state"
  type        = string
}

variable "terraform_lock_table" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
}

variable "index_document" {
  description = "Index document name for S3 website hosting"
  default     = "index.html"
}

variable "error_document" {
  description = "Error document name for S3 website hosting"
  default     = "error.html"
}