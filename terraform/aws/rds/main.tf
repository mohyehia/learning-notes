terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      "source"  = "hashicorp/aws"
      "version" = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = "<access_key>"
  secret_key = "<secret_key>"
}

resource "aws_security_group" "terraform_security_group" {
  name = var.security_group_name
  description = var.security_group_description
  tags = {
    Name = var.security_group_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_db_access" {
  security_group_id = aws_security_group.terraform_security_group.id
  ip_protocol = "TCP"
  from_port = 3306
  to_port = 3306
  cidr_ipv4 = "0.0.0.0/0"
  tags = {
    Name = "allow_db_access"
  }
}

resource "aws_db_instance" "terraform_rds_demo" {
  identifier = var.db_identifier
  allocated_storage = 2
  engine = var.engine
  instance_class = var.instance_class
  db_name = var.db_name
  username = var.username
  password = var.password
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.terraform_security_group.id]
}

// print the created RDS endpoint
output "rds_endpoint" {
  description = "The endpoint of the created RDS instance"
  value = aws_db_instance.terraform_rds_demo.endpoint
}