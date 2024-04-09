resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.terraform_test.id
  service_name = "com.amazonaws.us-west-1.s3"

  tags = {
    Environment = "Test"
    Name        = "S3 Endpoint test"
  }
}

