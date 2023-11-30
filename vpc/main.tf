variable "instance_count" {
  default = 5000
}

resource "random_shuffle" "az" {
  input = ["us-west-1b", "us-west-1c"]
}

resource "aws_instance" "server" {
  count = var.instance_count

  ami           = "ami-080d1454ad4fabd12"
  instance_type = "t3.micro"

  availability_zone = element(random_shuffle.az.result, count.index)

  tags = {
    Name = "server${count.index + 1}"
  }
}