
locals {
  regions = ["us-east-1", "eu-west-1"]
}

locals {
  instance_tenancy = "default"
}


locals {
  ingress_rules = [
    # Ingress rule for SSH (port 22)
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    # Ingress rule for MySQL (port 3306)
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    # Ingress rule for ICMP (ping)
    {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}

locals {
  external_subnet_ids = [for vpc_key, vpc in aws_vpc.network : aws_subnet.external_subnet[vpc_key].id]
  ssh_port_range      = "22"
}
