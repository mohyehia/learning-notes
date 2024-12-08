variable "region" {
  default = "<region>"
}

variable "security_group_name" {
  default = "terraform_rds_security_group"
}

variable "security_group_description" {
  default = "Example for security group for RDS created by terraform"
}

variable "engine" {
  default = "mysql"
}

variable "instance_class" {
  default = "db.t4g.micro"
}

variable "db_identifier" {
  default = "demo_db_identifier"
}

variable "db_name" {
  default = "mydb"
}

variable "username" {
  default = "admin"
}

variable "password" {
  default = "password0000"
}