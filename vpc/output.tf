output "subnet_id" {
  value = aws_subnet.public1.id
}

output "vpc_id" {
  value = aws_vpc.terraform_test.id
}

output "vpc_cidr" {
  value = aws_vpc.terraform_test.cidr_block
}