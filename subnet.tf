resource "aws_subnet" "external_subnet" {
  for_each = var.vpcs

  vpc_id     = aws_vpc.network[each.key].id
  cidr_block = cidrsubnet(each.value.cidr_block, 8, 1)
  availability_zone = length(data.aws_availability_zones.available[each.value.region].names) > 0 ? element(data.aws_availability_zones.available[each.value.region].names, 0) : null

  tags = {
    Name = "External-Subnet-${each.key}"
  }
}

resource "aws_subnet" "internal_subnet" {
  for_each = var.vpcs

  vpc_id     = aws_vpc.network[each.key].id
  cidr_block = cidrsubnet(each.value.cidr_block, 8, 2)
  availability_zone = length(data.aws_availability_zones.available[each.value.region].names) > 0 ? element(data.aws_availability_zones.available[each.value.region].names, 0) : null

  tags = {
    Name = "Internal-Subnet-${each.key}"
  }
}

resource "aws_subnet" "db_subnet" {
  for_each = var.vpcs

  vpc_id     = aws_vpc.network[each.key].id
  cidr_block = cidrsubnet(each.value.cidr_block, 8, 3)
  availability_zone = length(data.aws_availability_zones.available[each.value.region].names) > 0 ? element(data.aws_availability_zones.available[each.value.region].names, 0) : null

  tags = {
    Name = "DB-Subnet-${each.key}"
  }
}
