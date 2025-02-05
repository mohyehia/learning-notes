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
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
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
resource "aws_subnet" "public_subnet_a" {
  vpc_id                                         = aws_vpc.demo_vpc.id
  cidr_block                                     = "10.0.0.0/24"
  availability_zone                              = "eu-west-1a"
  map_public_ip_on_launch                        = true
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  tags = {
    Name = var.public_subnet_name_a
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                                         = aws_vpc.demo_vpc.id
  cidr_block                                     = "10.0.1.0/24"
  availability_zone                              = "eu-west-1b"
  map_public_ip_on_launch                        = true
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  tags = {
    Name = var.public_subnet_name_b
  }
}

# Define the private subnets
resource "aws_subnet" "private_subnet_a" {
  vpc_id                                         = aws_vpc.demo_vpc.id
  cidr_block                                     = "10.0.16.0/20"
  availability_zone                              = "eu-west-1a"
  map_public_ip_on_launch                        = false
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  tags = {
    Name = var.private_subnet_name_a
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id                                         = aws_vpc.demo_vpc.id
  cidr_block                                     = "10.0.32.0/20"
  availability_zone                              = "eu-west-1b"
  map_public_ip_on_launch                        = false
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  tags = {
    Name = var.private_subnet_name_b
  }
}

# Define the Internet Gateway
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = var.internet_gateway_name
  }
}

# Define the elastic IP
resource "aws_eip" "nat_ip" {
  domain = "vpc"
  tags = {
    Name = "nat_eip"
  }
}

# Define the NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  subnet_id = aws_subnet.public_subnet_a.id # Any public subnet
  allocation_id = aws_eip.nat_ip.id
  tags = {
    Name = var.nat_gateway_name
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
  route {
    cidr_block = "0.0.0.0/0" # route all traffic that doesn't match the VPC IPs to the NAT gateway
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = var.private_route_table_name
  }
}

# Define the Public Route Table Associations
resource "aws_route_table_association" "public_association_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_association_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}

# Define the Private Route Table Associations
resource "aws_route_table_association" "private_association_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_association_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_route_table.id
}

# Define the Outputs
output "vpc_id" {
  value       = aws_vpc.demo_vpc.id
  description = "ID of the created VPC"
}

output "public_subnet_ids" {
  value = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
  description = "IDs of the public subnets"
}

output "private_subnet_ids" {
  value = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
  description = "IDs of the private subnets"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.gateway.id
  description = "ID of the created Internet Gateway"
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.nat_gateway.id
  description = "ID of the created NAT Gateway"
}

output "public_route_table_id" {
  value       = aws_route_table.public_route_table.id
  description = "ID of the public route table"
}

output "private_route_table_id" {
  value       = aws_route_table.private_route_table.id
  description = "ID of the private route table"
}