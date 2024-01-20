resource "aws_security_group" "rds_ec2_test" {
  name   = "rds_ec2_sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "ec2_rds_test" {
  name   = "ec2_rds_sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "rds_ec2" {
  type                     = "ingress"
  to_port                  = 5432
  from_port                = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_ec2_test.id
  source_security_group_id = aws_security_group.ec2_rds_test.id
}

resource "aws_security_group_rule" "ec2_rds" {
  type                     = "egress"
  to_port                  = 5432
  from_port                = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_rds_test.id
  source_security_group_id = aws_security_group.rds_ec2_test.id
}
