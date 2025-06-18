terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  # AWS credentials should be configured via:
  # 1. AWS CLI: aws configure
  # 2. Environment variables: AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
  # 3. Or shared credentials file: ~/.aws/credentials
}