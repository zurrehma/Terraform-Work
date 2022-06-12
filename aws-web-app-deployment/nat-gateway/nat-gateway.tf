#This module will create nat gateway in one of the public subnet
resource "aws_eip" "public_ips" {}

locals {
  common_tags = {
    "Created_By" = "Terraform"
    "Managed_By" = "Terraform"
    "Createed_At" = timestamp()
  }
}

resource "aws_nat_gateway" "natgateway" {
  allocation_id = aws_eip.public_ips.id
  subnet_id = var.subnet_ids[0]
  depends_on = [
    var.gateway_id
  ]
  tags = merge({
      "Name" = "three-tier-nat-gateway"
  },
  local.common_tags
  )
  lifecycle {
    ignore_changes = [tags["Created_At"]]
  }

}

output "nat_gateway_id" {
  value = aws_nat_gateway.natgateway.id
}
