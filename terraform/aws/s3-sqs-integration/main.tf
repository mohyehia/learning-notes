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

// create the sqs
resource "aws_sqs_queue" "terraform_demo_sqs" {
  name                       = var.sqs_queue_name
  delay_seconds              = 5
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
  max_message_size           = 262144
  receive_wait_time_seconds  = 5
  sqs_managed_sse_enabled    = true
  tags = {
    Name        = var.sqs_queue_name
    Environment = "Dev"
  }
}

// sleep for 30 seconds after creating the sqs so that the policy creation can be done
# resource "time_sleep" "wait_30_seconds" {
#   depends_on = [aws_sqs_queue.terraform_demo_sqs]
#   create_duration = "30s"
# }

// create the sqs policy
data "aws_iam_policy_document" "demo_sqs_policy_document" {
  # depends_on = [
  #   time_sleep.wait_30_seconds
  # ]
  statement {
    sid    = "1"
    resources = [aws_sqs_queue.terraform_demo_sqs.arn]
    effect = "Allow"
    principals {
      identifiers = ["*"]
      type = "AWS"
    }
    actions = [
      "sqs:SendMessage"
    ]
  }
}

// attach the created sqs policy to the queue
resource "aws_sqs_queue_policy" "demo_sqs_policy" {
  queue_url = aws_sqs_queue.terraform_demo_sqs.id
  policy    = data.aws_iam_policy_document.demo_sqs_policy_document.json
}

// create the s3 bucket
resource "aws_s3_bucket" "terraform_demo_s3_bucket" {
  bucket = var.bucket_name
  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}

// allow versioning for bucket objects (optional)
resource "aws_s3_bucket_versioning" "terraform_demo_versioning" {
  bucket = aws_s3_bucket.terraform_demo_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

// add the event notification from the s3 bucket to the sqs queue for objects creation with filtration criteria as specified
resource "aws_s3_bucket_notification" "demo_bucket_notification" {
  depends_on = [
    aws_sqs_queue.terraform_demo_sqs,
    aws_s3_bucket.terraform_demo_s3_bucket,
    aws_sqs_queue_policy.demo_sqs_policy
  ]
  bucket = aws_s3_bucket.terraform_demo_s3_bucket.id
  queue {
    queue_arn     = aws_sqs_queue.terraform_demo_sqs.arn
    events = ["s3:ObjectCreated:*"]
    filter_suffix = ".jpg"
  }
}