resource "aws_security_group" "peer_sg" {
  name   = "peer sg"
  vpc_id = var.peer_vpc_id
}

resource "aws_security_group" "sg" {
  name   = "main sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "peer_ingress" {
  from_port                = 8
  to_port                  = 0
  protocol                 = "icmp"
  security_group_id        = aws_security_group.peer_sg.id
  type                     = "ingress"
  description              = "ingress ICMP rule for peer"
  source_security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "ingress" {
  from_port                = 8
  to_port                  = 0
  protocol                 = "icmp"
  security_group_id        = aws_security_group.sg.id
  type                     = "ingress"
  description              = "ingress ICMP rule for main"
  source_security_group_id = aws_security_group.peer_sg.id
}