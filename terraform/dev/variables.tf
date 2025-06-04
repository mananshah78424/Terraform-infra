variable "aws_region" {
    description = "The AWS region to deploy resources to"
    type = string
    default = "us-east-1"
}

variable "aws_profile" {
    description = "The AWS CLI profile to use"
    type = string
    default = "default"
}

variable "cors_allowed_origins" {
  description = "List of allowed origins for S3 CORS"
  type        = list(string)
  default     = ["*"]  # Safe for dev, override for prod
}

variable "rds_dbname" {
  description = "The name of the RDS database"
  type        = string
}

variable "rds_username" {
  description = "The master username for the RDS instance"
  type        = string
}

variable "rds_password" {
  description = "The master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "cidr_block_ingress" {
  description = "List of allowed cidr block for ingress"
  type = list(string)
  default = ["0.0.0.0/0"]
} 