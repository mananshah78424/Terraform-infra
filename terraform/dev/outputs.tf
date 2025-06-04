output "dev_sqs_fixtures_daily_queue_url" {
  description = "The URL of the dev SQS queue"
  value       = module.sqs_fixtures_daily.queue_url
}

output "dev_sqs_fixtures_daily_queue_arn" {
  description = "The ARN of the dev SQS queue"
  value       = module.sqs_fixtures_daily.queue_arn
}

output "dev_sqs_fixtures_daily_s3_events_queue_url" {
  description = "The URL of the dev SQS queue"
  value       = module.sqs_fixtures_daily_s3_events.queue_url
}

output "dev_sqs_fixtures_daily_s3_events_queue_arn" {
  description = "The ARN of the dev SQS queue"
  value       = module.sqs_fixtures_daily_s3_events.queue_arn
}

output "dev_s3_bucket_name" {
  value = module.s3.bucket_name
}

output "dev_s3_bucket_arn" {
  value = module.s3.bucket_arn
}

output "dev_rds_endpoint" {
  value = module.rds.db_endpoint
}

output "dev_rds_identifer" {
  value = module.rds.db_identifier
}