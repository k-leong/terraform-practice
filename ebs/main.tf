resource "aws_ebs_volume" "test" {
  count = length(var.az)

  availability_zone = var.az[count.index]
  size              = 20
  encrypted         = true

  tags = {
    Name = "test ${count.index + 1}"
  }
}

resource "aws_volume_attachment" "test_att" {
  count = length(var.instance)

  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.test[count.index].id
  instance_id = var.instance[count.index]
}