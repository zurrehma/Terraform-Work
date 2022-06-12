resource "aws_security_group" "nat" {
  name = "nat"
  description = "Allow nat traffic"
  vpc_id = var.vpc_id

  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

output "aws_nat_sg_id" {
  value = aws_security_group.nat.id
}