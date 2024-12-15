variable "region" {
  default = "<region>"
}

variable "security_group_name" {
  default = "terraform_redis_security_group"
}

variable "security_group_description" {
  default = "Example for security group for Redis created by terraform"
}

variable "engine" {
  default = "redis"
}

variable "engine_version" {
  default = "7.1"
}

variable "redis_node_type" {
  default = "cache.t4g.micro"
}

variable "redis_parameter_group" {
  default = "default.redis7"
}

variable "redis_identifier" {
  default = "demo_redis_identifier"
}