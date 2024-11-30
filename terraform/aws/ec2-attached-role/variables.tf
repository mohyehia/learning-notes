variable "region" {
  default = "<region>"
}

variable "ami" {
  default = "ami-02141377eee7defb9"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_name" {
  default = "Terraform EC2 Demo Attached Role"
}

variable "security_group_name" {
  default = "terraform_security_group"
}

variable "security_group_description" {
  default = "Example for security group created by terraform"
}