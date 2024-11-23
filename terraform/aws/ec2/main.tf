terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.6.0"
}

provider "aws" {
  region     = "<region>"
  access_key = "<access_key>"
  secret_key = "<secret_key>"
}

resource "aws_instance" "demo_terraform_ec2" {
  ami           = "ami-02141377eee7defb9"
  instance_type = "t2.micro"
  tags = {
    Name = "Terraform EC2 Demo"
  }
}