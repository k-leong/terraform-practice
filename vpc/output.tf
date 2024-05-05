output "public_subnet_ids" {
  value = [aws_subnet.public1.id, aws_subnet.public2.id]
}

output "private_subnet_ids" {
  value = [aws_subnet.private1.id, aws_subnet.private2.id]
}

output "vpc_id" {
  value = aws_vpc.terraform_test.id
}

output "igw_id" {
  value = aws_internet_gateway.terraform_ig.id
}