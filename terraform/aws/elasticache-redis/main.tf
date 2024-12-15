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
  from_port = 6379
  to_port = 6379
  cidr_ipv4 = "0.0.0.0/0"
  tags = {
    Name = "allow_cache_access"
  }
}

resource "aws_elasticache_cluster" "terraform_demo_redis" {
  cluster_id = "demo-redis"
  apply_immediately = true
  engine = var.engine
  node_type = var.redis_node_type
  engine_version = var.engine_version

  num_cache_nodes = 1
  parameter_group_name = var.redis_parameter_group
  port = 6379

  security_group_ids = [aws_security_group.terraform_security_group.id]
  tags = {
    Name = var.redis_identifier
  }
}

// print the created Redis endpoint
output "redis_endpoint" {
  description = "The endpoint of the created Redis instance"
  value = aws_elasticache_cluster.terraform_demo_redis.cache_nodes[0].address
}