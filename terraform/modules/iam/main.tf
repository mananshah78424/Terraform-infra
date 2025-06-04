# Create IAM user
resource "aws_iam_user" "this" {
  name = var.user_name
  path = var.user_path

  tags = {
    Environment = var.environment
    Purpose     = var.purpose
  }
}

# Create access key
resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

# Create IAM policy
resource "aws_iam_policy" "this" {
  name        = "${var.user_name}-policy"
  description = "Policy for ${var.user_name}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = var.policy_actions
        Resource = "*"
      }
    ]
  })
}

# Attach policy to user
resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this.arn
} 