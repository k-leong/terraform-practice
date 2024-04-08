resource "aws_route" "peer_to_main_route" {
  route_table_id            = aws_route_table.peer_rt.id
  destination_cidr_block    = var.main_cidr
  vpc_peering_connection_id = var.peering_cx_id #target
}

resource "aws_route_table" "peer_rt" {
  vpc_id = var.peer_vpc_id

  tags = {
    Name = "peer rt"
  }
}

resource "aws_route_table_association" "peer_rt_assoc" {
  route_table_id = aws_route_table.peer_rt.id
  subnet_id      = var.peer_subnet
}

resource "aws_route" "main_to_peer_route" {
  route_table_id            = aws_route_table.main_rt.id
  destination_cidr_block    = var.peer_cidr
  vpc_peering_connection_id = var.peering_cx_id #target
}

resource "aws_route_table" "main_rt" {
  vpc_id = var.main_vpc_id

  tags = {
    Name = "main rt"
  }
}

resource "aws_route_table_association" "main_rt_assoc" {
  route_table_id = aws_route_table.main_rt.id
  subnet_id      = var.main_subnet
}

resource "aws_route" "main_to_internet" {
  route_table_id = aws_route_table.main_rt.id
  gateway_id = aws_internet_gateway.ig.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "ig" {
  vpc_id = var.main_vpc_id

  tags = {
    Name = "terraform ig"
  }
}
# resource "aws_route_table_association" "name" {
#   route_table_id = aws_route_table.main_rt.id
#   subnet_id = var.main_subnet
# }