resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "tf test"
  }
}

resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-1b"

  tags = {
    Name = "tf public subnet1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "10.0.16.0/24"
  availability_zone = "us-west-1c"

  tags = {
    Name = "tf public subnet2"
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "10.0.128.0/24"
  availability_zone = "us-west-1b"

  tags = {
    Name = "tf private subnet1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "10.0.144.0/24"
  availability_zone = "us-west-1c"

  tags = {
    Name = "tf private subnet2"
  }
}