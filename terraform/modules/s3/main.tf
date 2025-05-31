resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}


resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_cors_configuration"  "this" {
    bucket = aws_s3_bucket.this.id
    cors_rule {
        allowed_methods = ["GET", "PUT", "POST"]
        allowed_origins = var.cors_allowed_origins
        allowed_headers = ["*"]
    }
}