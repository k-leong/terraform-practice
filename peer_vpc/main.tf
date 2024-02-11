resource "aws_vpc" "test_peer" {
  cidr_block           = "10.30.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "test peer"
  }
}

resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.test_peer.id
  cidr_block        = "10.30.0.0/24"
  availability_zone = "us-west-1b"

  tags = {
    Name = "public subnet 1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.test_peer.id
  cidr_block        = "10.30.30.0/24"
  availability_zone = "us-west-1c"

  tags = {
    Name = "public subnet 2"
  }
}