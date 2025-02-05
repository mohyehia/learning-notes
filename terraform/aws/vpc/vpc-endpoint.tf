terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      "source"  = "hashicorp/aws"
      "version" = "~> 5.0"
    }
  }
}

# Define the VPC
resource "aws_vpc" "demo_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = false
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
  }
}

# Define the public subnets
resource "aws_subnet" "public_subnet" {
  vpc_id                                         = aws_vpc.demo_vpc.id
  cidr_block                                     = "10.0.0.0/24"
  availability_zone                              = "eu-west-1a"
  map_public_ip_on_launch                        = true
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  tags = {
    Name = "public-subnet"
  }
}


# Define the private subnets
resource "aws_subnet" "private_subnet" {
  vpc_id                                         = aws_vpc.demo_vpc.id
  cidr_block                                     = "10.0.16.0/20"
  availability_zone                              = "eu-west-1a"
  map_public_ip_on_launch                        = false
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  tags = {
    Name = "private-subnet"
  }
}

# Define the Internet Gateway
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = var.internet_gateway_name
  }
}

# Define the route tables
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.demo_vpc.id
  route {
    cidr_block = "0.0.0.0/0" # route all traffic that doesn't match the VPC IPs to the Internet gateway
    gateway_id = aws_internet_gateway.gateway.id
  }
  tags = {
    Name = var.public_route_table_name
  }
}

# Add a route with the NAT Gateway for the private route
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = var.private_route_table_name
  }
}

# Define the Public Route Table Associations
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Define the Private Route Table Associations
resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

# Define the VPC endpoint
resource "aws_vpc_endpoint" "demo_vpc_endpoint" {
  vpc_id       = aws_vpc.demo_vpc.id
  service_name = "com.amazonaws.eu-west-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [aws_route_table.private_route_table.id]
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "*",
        "Resource": "*"
      }
    ]
  })
  tags = {
    Name = "demo-vpc-endpoint"
  }
}

# Define the Outputs
output "demo_vpc_id" {
  value       = aws_vpc.demo_vpc.id
  description = "ID of the created VPC"
}

output "public_subnet_id" {
  value = [aws_subnet.public_subnet.id]
  description = "ID of the public subnet"
}

output "private_subnet_id" {
  value = [aws_subnet.private_subnet.id]
  description = "ID of the private subnet"
}

output "demo_internet_gateway_id" {
  value       = aws_internet_gateway.gateway.id
  description = "ID of the created Internet Gateway"
}

output "demo_public_route_table_id" {
  value       = aws_route_table.public_route_table.id
  description = "ID of the public route table"
}

output "demo_private_route_table_id" {
  value       = aws_route_table.private_route_table.id
  description = "ID of the private route table"
}

output "demo_gateway_endpoint_id" {
  value = aws_vpc_endpoint.demo_vpc_endpoint.id
  description = "ID of the created VPC Endpoint"
}