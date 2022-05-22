resource "aws_internet_gateway" "threetier-webgateway" {
  vpc_id = var.vpc_id
  tags = merge(
    var.igw_tags,
    {
      Created_By = "Terraform"
      Managed_By = "Terraform"
      Created_At = timestamp()
    },
    {
      Name = var.igw_tags.igw_name
    },
  )
}

