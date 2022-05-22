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