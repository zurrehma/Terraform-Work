//create route table for public subnets
//https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "routetable_public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }

  tags = {
    "Managed_By" = "Terraform"
    "Associated_With" = "PublicSubnets"
  }
}

//associate route table with subnet
//https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "routetable-subnet" {
  count = 2
  subnet_id = var.subnet_ids[count.index]
  route_table_id = aws_route_table.routetable_public.id
}