variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "versioning" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = false
}

variable "cors_allowed_origins" {
  description = "List of allowed origins for S3 CORS"
  type        = list(string)
  default     = ["*"]
}