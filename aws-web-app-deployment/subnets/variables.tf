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

variable "vpc_id" {}