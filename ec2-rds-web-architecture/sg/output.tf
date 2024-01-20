output "rds_ec2_id" {
  value = aws_security_group.rds_ec2_test.id
}

output "ec2_rds_id" {
  value = aws_security_group.ec2_rds_test.id
}