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
  access_key = var.access_key
  secret_key = var.secret_key
}


resource "aws_dynamodb_table" "terraform_dynamodb_demo" {
  name = var.table_name
  billing_mode = var.billing_mode
  table_class = var.table_class
  read_capacity = var.rcu
  write_capacity = var.wcu
  hash_key = var.partition_key_name # primary key
  range_key = var.sort_key_name # sort key

  attribute {
    name = var.partition_key_name
    type = "S"
  }

  attribute {
    name = var.sort_key_name
    type = "S"
  }

  ttl {
    attribute_name = var.ttl_attribute_name
    enabled = true
  }

  tags = {
    Name = var.table_name
    Environment = var.environment
  }
}