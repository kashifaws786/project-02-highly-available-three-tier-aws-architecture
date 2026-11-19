
# Allocate two Elastic IP addresses for the NAT Gateways.

resource "aws_eip" "nat" {
  count  = 2
  domain = "vpc"

  tags = {
    Name = "${var.name_prefix}-nat-eip-${count.index + 1}"
  }
}

# Create one public NAT Gateway in each Availability Zone.

resource "aws_nat_gateway" "main" {
  count = 2

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "${var.name_prefix}-nat-${count.index + 1}"
  }

  # Ensure the public internet route exists before creating NAT Gateways.
  depends_on = [
    aws_route.public_internet,
    aws_route_table_association.public
  ]
}
