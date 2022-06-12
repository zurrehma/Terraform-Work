terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  date = timestamp()
}

module "vpc" {
  source     = "./vpc"
  cidr_block = var.cidr_block
  vpc_tags   = var.vpc_tags
}

module "igw" {
  source   = "./internet-gateway"
  igw_tags = var.igw_tags
  vpc_id   = module.vpc.vpc_id
}

module "subnets" {
  source               = "./subnets"
  vpc_id               = module.vpc.vpc_id
  no_of_public_subnet  = var.no_of_public_subnet
  no_of_private_subnet = var.no_of_private_subnet
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidr  = var.private_subnet_cidr
}

module "routetable" {
  source     = "./route-table"
  vpc_id     = module.vpc.vpc_id
  gateway_id = module.igw.gateway_id
  subnet_ids = module.subnets.subnet_id
  private_subnet_ids = module.subnets.private_subnet_id
  nat_gateway_id = module.nat.nat_gateway_id
}


# module "nat" {
#   source = "./terraform-aws-nat-instances-ha"

#   aws_key_name = var.aws_key_name

#   public_subnet_ids  = module.subnets.subnet_id
#   private_subnet_ids = module.subnets.private_subnet_id

#   vpc_security_group_ids = [module.securitygroups.aws_nat_sg_id]
#   depends_on = [
#     module.subnets
#   ]
# }

module "nat" {
  source = "./nat-gateway"

  gateway_id = module.igw.gateway_id
  subnet_ids = module.subnets.subnet_id
}

# module "securitygroups" {
#   source = "./sec-groups"
#   vpc_id = module.vpc.vpc_id
# }

output "timestamp" {
  value = local.date
}

# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

# output "availibility_zone" {
#   value = module.vpc.availibility_zone
# }


### this will create key pair
### using <terraform output private_key> will print the private key
# resource "tls_private_key" "this" {
#   algorithm = "RSA"
# }

# module "key_pair" {
#   source = "terraform-aws-modules/key-pair/aws"

#   key_name   = var.aws_key_name
#   public_key = tls_private_key.this.public_key_openssh

# }

# output "private_key" {
#   value     = tls_private_key.this.private_key_pem
#   sensitive = true
# }