
resource "aws_vpc" "network" {
  for_each = var.vpcs

  cidr_block = each.value.cidr_block
  instance_tenancy = each.value.instance_tenancy

  tags = {
    Name = "VPC-${each.key}"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "igw" {
  for_each = var.vpcs

  vpc_id = aws_vpc.network[each.key].id

  tags = {
    Name = "Internet-Gateway-${each.key}"
  }
}
