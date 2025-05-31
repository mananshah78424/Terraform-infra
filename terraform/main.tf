
module "sqs" {
    source = "./modules/sqs"
    queue_name = "fixtures-daily-service-queue"
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "fixtures-daily-details-bucket"
  versioning  = true  # or false if you don't want versioning
  cors_allowed_origins = var.cors_allowed_origins
}

module "vpc" {
  source = "./modules/vpc"
}

module "db_sg" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  cidr_block_ingress=var.cidr_block_ingress
}

module "rds" {
  source                 = "./modules/rds"
  db_name                = var.rds_dbname
  db_username            = var.rds_username
  db_password            = var.rds_password
  db_subnet_ids          = module.vpc.public_subnet_ids
  vpc_security_group_ids = [module.db_sg.security_group_id]
}