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
  region     = "<region>"
  access_key = "<access_key>"
  secret_key = "<secret_key>"
}

resource "aws_security_group" "terraform_ec2_security_group" {
  name        = "terraform_security_group"
  description = "Example for security group created by terraform"
  // inbound rules
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // outbound rules
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "demo_terraform_ec2_user_data" {
  ami           = "ami-02141377eee7defb9"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform_ec2_security_group.id]
  tags = {
    Name = "Terraform EC2 Demo User Data"
  }
  user_data = file("user_data.sh")
}