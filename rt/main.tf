resource "aws_route_table" "test_rt" {
  vpc_id = var.vpc_id
}

resource "aws_route_table_association" "public1" {
  subnet_id = var.subnet_id[0]
  route_table_id = aws_route_table.test_rt.id
}

resource "aws_route_table_association" "public2" {
  subnet_id = var.subnet_id[1]
  route_table_id = aws_route_table.test_rt.id
}

resource "aws_route" "name" {
  route_table_id = aws_route_table.test_rt.id
  gateway_id = var.ig_id
  destination_cidr_block = "0.0.0.0/0"
}