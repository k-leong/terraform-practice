resource "aws_vpc" "terraform_test" {
  cidr_block = "172.30.0.0/16"

  tags = {
    Name = "terraform test"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.terraform_test.id
  cidr_block        = "172.30.0.0/24"
  availability_zone = "us-west-1b"

  tags = {
    Name = "public"
  }
}

output "subnet_id" {
  value = aws_subnet.public.id
}

output "vpc_id" {
  value = aws_vpc.terraform_test.id
}

resource "aws_route_table" "test" {
  vpc_id = aws_vpc.terraform_test.id

  tags = {
    Name = "test"
  }
}

resource "aws_route_table_association" "test" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.test.id
}

resource "aws_vpc_endpoint_route_table_association" "s3_route" {
  route_table_id = aws_route_table.test.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}