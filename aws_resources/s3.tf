resource "aws_s3_bucket" "my_first_bucket" {
  bucket = "my-tf-test-bucket-123456789987654321123456789789456"

  tags = {
    Name = "My first bucket"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.terraform_test.id
  service_name = "com.amazonaws.us-west-1.s3"

  tags = {
    Environment = "Test"
    Name        = "S3 Endpoint test"
  }
}

output "s3_endpoint" {
  value = aws_vpc_endpoint.s3.id
}