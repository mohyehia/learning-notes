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


resource "aws_s3_bucket" "terraform_demo_s3_bucket" {
  bucket = var.bucket_name
  tags = {
    Name = var.bucket_name
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "terraform_demo_versioning" {
  bucket = aws_s3_bucket.terraform_demo_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "ownership_ctr_demo" {
  bucket = aws_s3_bucket.terraform_demo_s3_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_access_demo" {
  bucket = aws_s3_bucket.terraform_demo_s3_bucket.id
  block_public_acls = true
  block_public_policy = false
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "allow_public_access_policy" {
  bucket = aws_s3_bucket.terraform_demo_s3_bucket.id
  depends_on = [aws_s3_bucket_ownership_controls.ownership_ctr_demo]
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3:GetObject"
        Effect = "Allow"
        Sid    = ""
        Principal = "*"
        Resource = "${aws_s3_bucket.terraform_demo_s3_bucket.arn}/*"
      }
    ]
  })
}