output "sqs_fixtures_daily_queue_url" {
  description = "The URL of the SQS queue"
  value       = module.sqs_fixtures_daily.queue_url
}

output "sqs_fixtures_daily_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = module.sqs_fixtures_daily.queue_arn
}


output "sqs_fixtures_daily_s3_events_queue_url" {
  description = "The URL of the SQS queue"
  value       = module.sqs_fixtures_daily_s3_events.queue_url
}

output "sqs_fixtures_daily_s3_events_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = module.sqs_fixtures_daily_s3_events.queue_arn
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "s3_bucket_arn" {
  value = module.s3.bucket_arn
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "rds_identifer" {
  value = module.rds.db_identifier
}