resource "aws_security_group" "peer_sg" {
  name   = "peer sg"
  vpc_id = var.peer_vpc_id
}

resource "aws_security_group" "sg" {
  name   = "main sg"
  vpc_id = var.vpc_id
}