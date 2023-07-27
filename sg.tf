resource "aws_security_group" "sg" {
  for_each = var.vpcs

  name_prefix = "My-Security-Group-${each.key}"

  vpc_id = aws_vpc.network[each.key].id

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security-Group-${each.key}"
  }
}