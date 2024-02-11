output "peer_subnet_id" {
  value = [aws_subnet.public1.id, aws_subnet.public2.id]
}

output "vpc_id" {
  value = aws_vpc.test_peer.id
}

output "vpc_cidr" {
  value = aws_vpc.test_peer.cidr_block
}