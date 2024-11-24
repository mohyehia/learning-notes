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
  access_key = "<access_key>"
  secret_key = "<secret_key>"
}

resource "aws_security_group" "terraform_ec2_security_group" {
  name        = var.security_group_name
  description = var.security_group_description
  tags = {
    Name = var.security_group_name
  }
}

// inbound rules (ingress)
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.terraform_ec2_security_group.id
  ip_protocol       = "tcp"
  from_port = 22
  to_port = 22
  cidr_ipv4 = "0.0.0.0/0"
  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.terraform_ec2_security_group.id
  ip_protocol       = "tcp"
  from_port = 80
  to_port = 80
  cidr_ipv4 = "0.0.0.0/0"
  tags = {
    Name = "allow_http"
  }
}

// outbound rules (egress)
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.terraform_ec2_security_group.id
  ip_protocol       = "-1"
  cidr_ipv4 = "0.0.0.0/0"
  tags = {
    Name = "allow_all_traffic"
  }
}

resource "aws_instance" "demo_terraform_ec2_user_data" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.terraform_ec2_security_group.id]
  tags = {
    Name = var.instance_name
  }
  user_data = file("user_data.sh")
}