output "user_name" {
  description = "The name of the IAM user"
  value       = aws_iam_user.this.name
}

output "user_arn" {
  description = "The ARN of the IAM user"
  value       = aws_iam_user.this.arn
}

output "access_key_id" {
  description = "The access key ID"
  value       = aws_iam_access_key.this.id
  sensitive   = true
}

output "secret_access_key" {
  description = "The secret access key"
  value       = aws_iam_access_key.this.secret
  sensitive   = true
}

output "policy_arn" {
  description = "The ARN of the IAM policy"
  value       = aws_iam_policy.this.arn
}

output "credentials_instructions" {
  description = "Instructions for using the credentials"
  value       = <<-EOT
    IAM User created successfully!
    
    IMPORTANT: Save these credentials securely. They will only be shown once.
    
    Access Key ID: ${aws_iam_access_key.this.id}
    Secret Access Key: ${aws_iam_access_key.this.secret}
    
    To use these credentials:
    1. Configure AWS CLI:
       aws configure --profile ${aws_iam_user.this.name}
       # Enter the Access Key ID and Secret Access Key when prompted
    
    2. Or set environment variables:
       export AWS_ACCESS_KEY_ID="${aws_iam_access_key.this.id}"
       export AWS_SECRET_ACCESS_KEY="${aws_iam_access_key.this.secret}"
    
    3. Or add to ~/.aws/credentials:
       [${aws_iam_user.this.name}]
       aws_access_key_id = ${aws_iam_access_key.this.id}
       aws_secret_access_key = ${aws_iam_access_key.this.secret}
    
    Security Note:
    - These credentials have the following permissions: ${join(", ", var.policy_actions)}
    - Keep these credentials secure and never commit them to version control
    - Consider using AWS Secrets Manager or similar for production environments
  EOT
} 