variable "region" {
  default = "<region>"
}

variable "access_key" {
  default = "<access_key>"
}

variable "secret_key" {
  default = "<secret_key>"
}

variable "vpc_name" {
  default = "my-demo-vpc"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_name_a" {
  default = "public-subnet-a"
}

variable "public_subnet_name_b" {
  default = "public-subnet-b"
}

variable "private_subnet_name_a" {
  default = "private-subnet-a"
}

variable "private_subnet_name_b" {
  default = "private-subnet-b"
}

variable "internet_gateway_name" {
  default = "demo-igw"
}

variable "public_route_table_name" {
  default = "public-route-table"
}

variable "private_route_table_name" {
  default = "private-route-table"
}

variable "nat_gateway_name" {
  default = "demo-nat-gateway"
}