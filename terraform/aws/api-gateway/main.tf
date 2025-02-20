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

# API gateway
resource "aws_api_gateway_rest_api" "demo_api_gateway" {
  name        = "demo-api-gateway-terraform"
  description = "Example creating an API gateway using terraform"
  tags = {
    Name = "demo-api-gateway-terraform"
  }
}

# create a resource for the API to return list of products
resource "aws_api_gateway_resource" "demo_api_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.demo_api_gateway.id
  path_part   = "products"
  parent_id   = aws_api_gateway_rest_api.demo_api_gateway.root_resource_id
}

# create method for the above resource
resource "aws_api_gateway_method" "demo_api_gateway_method" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.demo_api_gateway_resource.id
  rest_api_id   = aws_api_gateway_rest_api.demo_api_gateway.id
}

# example for integration request
resource "aws_api_gateway_integration" "demo_api_gateway_integration" {
  http_method = aws_api_gateway_method.demo_api_gateway_method.http_method
  resource_id = aws_api_gateway_resource.demo_api_gateway_resource.id
  rest_api_id = aws_api_gateway_rest_api.demo_api_gateway.id
  type = "MOCK"
}

# create response model
resource "aws_api_gateway_model" "demo_api_gateway_response_model" {
  rest_api_id  = aws_api_gateway_rest_api.demo_api_gateway.id
  name         = "MyDemoResponseModel"
  description  = "API response for MyDemoMethod"
  content_type = "application/json"
  schema = jsonencode({
    "$schema" = "http://json-schema.org/draft-04/schema#"
    title     = "MyDemoResponse"
    type      = "object"
    properties = {
      Message = {
        type = "string"
      }
    }
  })
}

# create method response
resource "aws_api_gateway_method_response" "demo_api_gateway_method_response" {
  http_method = aws_api_gateway_method.demo_api_gateway_method.http_method
  resource_id = aws_api_gateway_resource.demo_api_gateway_resource.id
  rest_api_id = aws_api_gateway_rest_api.demo_api_gateway.id
  status_code = "200"
  response_models = {
    "application/json" = "MyDemoResponseModel"
  }
}

# define integration response
resource "aws_api_gateway_integration_response" "demo_api_gateway_integration_response" {
  http_method = aws_api_gateway_method.demo_api_gateway_method.http_method
  resource_id = aws_api_gateway_method.demo_api_gateway_method.resource_id
  rest_api_id = aws_api_gateway_rest_api.demo_api_gateway.id
  status_code = aws_api_gateway_method_response.demo_api_gateway_method_response.status_code
  depends_on = [aws_api_gateway_integration.demo_api_gateway_integration]
}

# Deployment
resource "aws_api_gateway_deployment" "demo_api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.demo_api_gateway.id
  depends_on = [aws_api_gateway_method.demo_api_gateway_method, aws_api_gateway_integration.demo_api_gateway_integration]
  lifecycle {
    create_before_destroy = true
  }
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.demo_api_gateway.body))
  }
}

# Stage
resource "aws_api_gateway_stage" "demo_api_gateway_stage" {
  deployment_id = aws_api_gateway_deployment.demo_api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.demo_api_gateway.id
  stage_name    = "dev"
  description = "Development Stage"
  tags = {
    Name = "dev"
  }
}

# output the api gateway url
output "api_gateway_url" {
  value       = aws_api_gateway_stage.demo_api_gateway_stage.invoke_url
  description = "API Gateway URL"
}