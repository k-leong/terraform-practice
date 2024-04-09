resource "aws_s3_bucket" "my_first_bucket" {
  bucket = "my-tf-test-bucket-123456789987654321123456789789456"

  tags = {
    Name = "My first bucket"
  }
}