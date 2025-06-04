module "sqs_fixtures_daily" {
    source = "../modules/sqs"
    queue_name = "dev-fixtures-daily-service-queue"
}

module "s3" {
  source      = "../modules/s3"
  bucket_name = "dev-fixtures-daily-details-bucket"
  versioning  = true  # or false if you don't want versioning
  cors_allowed_origins = var.cors_allowed_origins
}

module "vpc" {
  source = "../modules/vpc"
}

module "db_sg" {
  source = "../modules/security_group"
  vpc_id = module.vpc.vpc_id
  cidr_block_ingress=var.cidr_block_ingress
}

module "rds" {
  source                 = "../modules/rds"
  db_name                = "dev${var.rds_dbname}"
  db_username            = var.rds_username
  db_password            = var.rds_password
  db_subnet_ids          = module.vpc.public_subnet_ids
  vpc_security_group_ids = [module.db_sg.security_group_id]
}

module "sqs_fixtures_daily_s3_events" {
    source = "../modules/sqs"
    queue_name = "dev-fixtures-daily-s3-events-queue"
}

resource "aws_s3_bucket_notification" "s3_events" {
  bucket = module.s3.bucket_name

  queue {
    queue_arn = module.sqs_fixtures_daily_s3_events.queue_arn
    events = ["s3:ObjectCreated:*"]
  }
}