resource "aws_db_subnet_group" "this" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "${var.db_name}-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier              = var.db_name
  allocated_storage       = var.db_allocated_storage
  engine                  = "postgres"
  engine_version          = "17.5"
  instance_class          = var.db_instance_class
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  skip_final_snapshot     = true
  publicly_accessible     = true

  # Free tier settings
  backup_retention_period = 0
  multi_az                = false
  storage_type            = "gp2"
}