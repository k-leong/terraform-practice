resource "aws_s3_bucket" "my_first_bucket" {
  bucket = "my-tf-test-bucket-123456789987654321"
  
  tags = {
    Name = "My first bucket"
  }
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.my_first_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.my_first_bucket.id
  acl    = "private"
}