resource "aws_network_acl" "external_nacl" {
  for_each = var.vpcs

  vpc_id = aws_vpc.network[each.key].id

  tags = {
    Name = "External-NACL-${each.key}"
  }
}

resource "aws_network_acl" "internal_nacl" {
  for_each = var.vpcs

  vpc_id = aws_vpc.network[each.key].id

  tags = {
    Name = "Internal-NACL-${each.key}"
  }
}

resource "aws_network_acl" "db_nacl" {
  for_each = var.vpcs

  vpc_id = aws_vpc.network[each.key].id

  tags = {
    Name = "DB-NACL-${each.key}"
  }
}


resource "aws_network_acl_rule" "ssh_inbound" {
  for_each = aws_network_acl.external_nacl

  network_acl_id = each.value.id
  rule_number    = 100
  protocol       = "6"  # TCP
  rule_action    = "allow"
  egress         = false
  cidr_block     = "0.0.0.0/0"  # All IP addresses
  from_port      = local.ssh_port_range
  to_port        = local.ssh_port_range

}
