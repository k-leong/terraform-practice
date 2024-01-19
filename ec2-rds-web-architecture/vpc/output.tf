output "private1_subnet" {
  value = aws_subnet.private1.id
}

output "private2_subnet" {
  value = aws_subnet.private2.id
}

output "public_subnets" {
  value = [aws_subnet.public1.id, aws_subnet.public2.id]
}