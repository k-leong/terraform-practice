resource "aws_s3_bucket" "my_first_bucket" {
  bucket = "my-tf-test-bucket-123456789987654321123456789789456"

  tags = {
    Name = "My first bucket"
  }
}

resource "aws_s3_bucket_website_configuration" "my_first_bucket_website" {
  bucket = aws_s3_bucket.my_first_bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access" {
  bucket = aws_s3_bucket.my_first_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}