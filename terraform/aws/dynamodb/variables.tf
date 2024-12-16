variable "region" {
  default = "<region>"
}

variable "access_key" {
  default = "<access_key>"
}

variable "secret_key" {
  default = "<secret_key>"
}

variable "table_name" {
  default = "UsersDemo"
}

variable "environment" {
  default = "Dev"
}

variable "table_class" {
  default = "STANDARD"
}

variable "billing_mode" {
  default = "PROVISIONED"
}

variable "rcu" {
  default = 1
}

variable "wcu" {
  default = 1
}

variable "partition_key_name" {
  default = "user_id"
}

variable "sort_key_name" {
  default = "department"
}

variable "ttl_attribute_name" {
  default = "expiration_time"
}