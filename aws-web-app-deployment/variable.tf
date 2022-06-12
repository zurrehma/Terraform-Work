variable "aws_region" {
  default = "us-west-1"
}
variable "cidr_block" {
  default = "10.0.0.0/16"
  type    = string
}

variable "vpc_tags" {
  type = map(string)
  default = {
    "vpc_name" = "terraform-vpc"
    "env"      = "dev"
  }
}

variable "igw_tags" {
  type = map(string)
  default = {
    "igw_name" = "terraform-vpc"
    "env"      = "dev"
  }
}

variable "no_of_public_subnet" {
  default = 2
}

variable "no_of_private_subnet" {
  default = 2
}

variable "public_subnet_cidr" {
  default = 24
}
variable "private_subnet_cidr" {
  default = 24
}

variable "aws_key_name" {
  type    = string
  default = "threetier-keypair"
}