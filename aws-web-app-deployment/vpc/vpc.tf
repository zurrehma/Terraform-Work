#Create a VPC
resource "aws_vpc" "threetier-vpc" {
  cidr_block = var.cidr_block

  tags = merge(
    var.vpc_tags,
    {
      Created_By = "Terraform"
      Managed_By = "Terraform"
      Created_At = timestamp()
    },
  )
  #https://registry.terraform.io/providers/hashicorp/aws/latest/docs/guides/resource-tagging#ignoring-changes-in-individual-resources

  # lifecycle {
  #   ignore_changes = [tags]
  # }
}


output "vpc_id" {
  value = aws_vpc.threetier-vpc.id
}


