
# Create one private route table for each database subnet.

resource "aws_route_table" "db" {
  count = 2

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name_prefix}-db-rt-${count.index + 1}"
    Tier = "Database"
  }
}

# Associate each database subnet with its corresponding route table.

resource "aws_route_table_association" "db" {
  count = 2

  subnet_id      = aws_subnet.db[count.index].id
  route_table_id = aws_route_table.db[count.index].id
}
