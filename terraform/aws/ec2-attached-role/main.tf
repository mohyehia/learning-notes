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

// outbound rules (egress)
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  ip_protocol       = "-1"
  security_group_id = aws_security_group.terraform_security_group.id
  cidr_ipv4 = "0.0.0.0/0"
  tags = {
    Name = "allow_all_traffic"
  }
}

// inbound rules (ingress)
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.terraform_security_group.id
  ip_protocol       = "tcp"
  from_port = 22
  to_port = 22
  cidr_ipv4 = "0.0.0.0/0"
  tags = {
    Name = "allow_ssh"
  }
}

// create iam role
resource "aws_iam_role" "demo_role" {
  name = "TERRAFORM_DEMO_ROLE"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name = "TERRAFORM_DEMO_ROLE"
  }
}

// Above block is going to create IAM role but we can’t link this role to AWS instance and for that,
// we need EC2 instance Profile
resource "aws_iam_instance_profile" "demo_instance_profile" {
  name = "demo_instance_profile"
  role = aws_iam_role.demo_role.name
}

// now we have the role & instance profile but the role contains no policies,
// for that we need to add IAM Policies which allows EC2 instance to execute specific commands
// we will create aws_iam_role_policy and have the policy from the aws_iam_policy_document data block
resource "aws_iam_role_policy" "iam_role_policy_demo" {
  name = "TERRAFORM_IAM_POLICY"
  role   = aws_iam_role.demo_role.id
  policy = data.aws_iam_policy_document.iam_read_only_access.json
}

// Generates an IAM policy document in JSON format for use with resources that expect policy documents
data "aws_iam_policy_document" "iam_read_only_access" {
  statement {
    sid = "1"
    resources = ["*"]
    actions = [
      "iam:GenerateCredentialReport",
      "iam:GenerateServiceLastAccessedDetails",
      "iam:Get*",
      "iam:List*",
      "iam:SimulateCustomPolicy",
      "iam:SimulatePrincipalPolicy"
    ]
  }
}

// Attach above role to the below EC2 instance via the instance_profile
resource "aws_instance" "demo_terraform_ec2_attach_role" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.terraform_security_group.id]
  iam_instance_profile = aws_iam_instance_profile.demo_instance_profile.name
  tags = {
      Name = var.instance_name
  }
}