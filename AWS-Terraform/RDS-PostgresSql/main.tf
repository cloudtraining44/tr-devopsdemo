provider "aws" {
  region = "us-east-1"
}

locals {
  name = "demo-postgresql"
}

resource "aws_db_instance" "this" {

  identifier             = local.name
  db_name                = var.db_name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  vpc_security_group_ids = [aws_security_group.pgdb-SG.id]
  multi_az               = var.multi_az
  publicly_accessible    = var.publicly_accessible
  username               = var.username
  password               = "Winter2024!"

  allocated_storage     = var.allocated_storage
  storage_type          = var.storage_type
  max_allocated_storage = var.max_allocated_storage

  maintenance_window              = var.maintenance_window
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period

  deletion_protection      = var.deletion_protection
  delete_automated_backups = var.delete_automated_backups
  skip_final_snapshot      = var.skip_final_snapshot

  tags = {
    Name     = local.name
  }
}

/*data "aws_vpc" "vpc" {
  tags = {
    Name = "toyota-demo-vpc"
  }
}*/

resource "aws_security_group" "pgdb-SG" {
  name        = "${local.name}-SG"
  description = "${local.name}-SG"
#  vpc_id      = data.aws_vpc.vpc.id
  ingress {
    description = "Port 5432 from Everywhere"
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "${local.name}-SG"
  }
}