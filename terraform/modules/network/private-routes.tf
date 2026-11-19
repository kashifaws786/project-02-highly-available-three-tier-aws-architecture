
# Create one private route table for each Availability Zone.

resource "aws_route_table" "app" {
  count = 2

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name_prefix}-app-rt-${count.index + 1}"
    Tier = "Application"
  }
}

# Route application subnet internet traffic through its local NAT Gateway.

resource "aws_route" "app_nat" {
  count = 2

  route_table_id         = aws_route_table.app[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[count.index].id
}

# Associate each application subnet with its corresponding route table.

resource "aws_route_table_association" "app" {
  count = 2

  subnet_id      = aws_subnet.app[count.index].id
  route_table_id = aws_route_table.app[count.index].id
}
