resource "aws_sqs_queue_policy" "allow_s3_to_sqs_fixtures_daily_s3_events" {
    queue_url = module.sqs_fixtures_daily_s3_events.queue_url

    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
        Effect = "Allow"
        Principal = {
            Service = "s3.amazonaws.com"
        }
        Action = "SQS:SendMessage"
        Resource = module.sqs_fixtures_daily_s3_events.queue_arn
        Condition = {
            ArnLike = {
            "aws:SourceArn" = module.s3.bucket_arn
            }
        }
        }
    ]
    })
}