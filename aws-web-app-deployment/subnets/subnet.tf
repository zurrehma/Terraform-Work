data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnets" {
  vpc_id = var.vpc_id
  count = var.no_of_public_subnet
  cidr_block = "10.0.${count.index + 2}.0/${var.public_subnet_cidr}"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "Name" = "three-tier-public-subnet-${count.index}"
    "Created_By" = "Terraform"
    "Managed_By" = "Terraform"
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id = var.vpc_id
  count = var.no_of_private_subnet
  cidr_block = "10.0.${count.index}.0/${var.private_subnet_cidr}"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "Name" = "three-tier-private-subnet-${count.index}"
    "Created_By" = "Terraform"
    "Managed_By" = "Terraform"
  }
}

output "subnet_id" {
  value = aws_subnet.public_subnets[*].id
}
