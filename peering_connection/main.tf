resource "aws_vpc_peering_connection" "peering_test" {
  peer_vpc_id = var.peer_vpc_id
  vpc_id      = var.main_vpc_id

  tags = {
    Name = "peering test"
  }
}

resource "aws_vpc_peering_connection_accepter" "peering_test_accepter" {
  auto_accept               = true
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_test.id

  tags = {
    Side = "Accepter"
  }
}

resource "aws_vpc_peering_connection_options" "peering_test_options" {
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_test.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  depends_on = [aws_vpc_peering_connection_accepter.peering_test_accepter]
}