variable "igw_tags" {
  type = map(string)
  default = {
    "igw_name" = "terraform-igw"
    "env"      = "dev"
  }
}

# variable "vpc_id" {
#   description = "ID of the VPC in which security resources are deployed"
#   type = string
# }

variable "vpc_id" {}
