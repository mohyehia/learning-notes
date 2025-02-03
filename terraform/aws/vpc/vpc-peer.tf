terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      "source"  = "hashicorp/aws"
      "version" = "~> 5.0"
    }
  }
}

# Define VPC A (Requester)
resource "aws_vpc" "demo_vpc_peer_a" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = false
  enable_dns_support   = true
  tags = {
    Name = "demo-vpc-peer-a"
  }
}

#Define VPC B (Accepter)
resource "aws_vpc" "demo_vpc_peer_b" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = false
  enable_dns_support   = true
  tags = {
    Name = "demo-vpc-peer-b"
  }
}

#Define the internet gateway for VPC A
resource "aws_internet_gateway" "demo_igw_a" {
  vpc_id = aws_vpc.demo_vpc_peer_a.id
  tags = {
    Name = "demo-igw-a"
  }
}

#Define the internet gateway for VPC B
resource "aws_internet_gateway" "demo_igw_b" {
  vpc_id = aws_vpc.demo_vpc_peer_b.id
  tags = {
    Name = "demo-igw-b"
  }
}

# Define the public subnet for VPC A
resource "aws_subnet" "public_subnet_a" {
  vpc_id                                         = aws_vpc.demo_vpc_peer_a.id
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

# Define the public subnet for VPC B
resource "aws_subnet" "public_subnet_b" {
  vpc_id                                         = aws_vpc.demo_vpc_peer_b.id
  cidr_block                                     = "10.1.0.0/24"
  availability_zone                              = "eu-west-1b"
  map_public_ip_on_launch                        = true
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  tags = {
    Name = var.public_subnet_name_b
  }
}


# VPC Peering Connection (Requester Side)
resource "aws_vpc_peering_connection" "demo_vpc_peering" {
  vpc_id      = aws_vpc.demo_vpc_peer_a.id
  peer_vpc_id = aws_vpc.demo_vpc_peer_b.id
  auto_accept = true # Automatically accept the peering request (for same-account peering)
  tags = {
    Name = "demo-vpc-peering"
  }
}

# Define the Route Tables for VPC A (Add route for VPC B's CIDR & internet gateway for VPC A)
resource "aws_route_table" "route_table_a" {
  vpc_id = aws_vpc.demo_vpc_peer_a.id
  route {
    cidr_block = aws_vpc.demo_vpc_peer_b.cidr_block  # Route to VPC B
    vpc_peering_connection_id = aws_vpc_peering_connection.demo_vpc_peering.id
  }
  route {
    cidr_block = "0.0.0.0/0" # route all traffic that doesn't match the VPC IPs to the Internet gateway
    gateway_id = aws_internet_gateway.demo_igw_a.id
  }
  tags = {
    Name = "route_table_a"
  }
}

# Define the Route Tables for VPC B (Add route for VPC A's CIDR & internet gateway for VPC B)
resource "aws_route_table" "route_table_b" {
  vpc_id = aws_vpc.demo_vpc_peer_b.id
  route {
    cidr_block = aws_vpc.demo_vpc_peer_a.cidr_block  # Route to VPC A
    vpc_peering_connection_id = aws_vpc_peering_connection.demo_vpc_peering.id
  }
  route {
    cidr_block = "0.0.0.0/0" # route all traffic that doesn't match the VPC IPs to the Internet gateway
    gateway_id = aws_internet_gateway.demo_igw_b.id
  }
  tags = {
    Name = "route_table_b"
  }
}

# Define the Route Table Associations for VPC A
resource "aws_route_table_association" "route_table_association_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.route_table_a.id
}

# Define the Route Table Associations for VPC B
resource "aws_route_table_association" "route_table_association_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.route_table_b.id
}

# Define the Outputs
output "vpc_a_id" {
  value       = aws_vpc.demo_vpc_peer_a.id
  description = "ID of the VPC A"
}

output "vpc_b_id" {
  value       = aws_vpc.demo_vpc_peer_b.id
  description = "ID of the VPC B"
}

output "internet_gateway_id_a" {
  value       = aws_internet_gateway.demo_igw_a.id
  description = "ID of the created Internet Gateway A"
}

output "internet_gateway_id_b" {
  value       = aws_internet_gateway.demo_igw_b.id
  description = "ID of the created Internet Gateway B"
}

output "vpc_peering_connection_id" {
  value       = aws_vpc_peering_connection.demo_vpc_peering.id
  description = "ID of the VPC Peering Connection"
}