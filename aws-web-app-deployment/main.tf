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
  region = "us-west-1"
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
  source = "./internet-gateway"
  igw_tags = var.igw_tags
  vpc_id = module.vpc.vpc_id
}

module "subnets" {
  source = "./subnets"
  vpc_id = module.vpc.vpc_id
  no_of_public_subnet = var.no_of_public_subnet
  no_of_private_subnet = var.no_of_private_subnet
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "routetable" {
  source = "./route-table"
  vpc_id = module.vpc.vpc_id
  gateway_id = module.igw.gateway_id
  subnet_ids = module.subnets.subnet_id
}

output "timestamp" {
  value = local.date
}

# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

# output "availibility_zone" {
#   value = module.vpc.availibility_zone
# }