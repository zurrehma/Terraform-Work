data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  common_tags = {
    "Created_By" = "Terraform"
    "Managed_By" = "Terraform"
    "Createed_At" = timestamp()
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id = var.vpc_id
  count = var.no_of_public_subnet
  cidr_block = "10.0.${count.index + 2}.0/${var.public_subnet_cidr}"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = merge({
    "Name" = "three-tier-public-subnet-${count.index}"
  },
  local.common_tags
  )
  lifecycle {
    ignore_changes = [tags["Created_At"]]
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id = var.vpc_id
  count = var.no_of_private_subnet
  cidr_block = "10.0.${count.index}.0/${var.private_subnet_cidr}"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = merge({
    "Name" = "three-tier-private-subnet-${count.index}" 
  },
  local.common_tags
  )
  lifecycle {
    ignore_changes = [tags["Created_At"]]
  }
}

output "subnet_id" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnets[*].id
}