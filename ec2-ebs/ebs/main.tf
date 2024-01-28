resource "aws_ebs_volume" "test" {
  availability_zone = "us-west-1b"
  size = 20
  encrypted = true

  tags = {
    Name = "test"
  }
}

resource "aws_volume_attachment" "test_att" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.test.id
  instance_id = var.instance
}