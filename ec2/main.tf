variable "instance_count" {
  default = 5
}

resource "random_shuffle" "az" {
  input = ["us-west-1b", "us-west-1c"]
}

module "vpc_module" {
  source = "../vpc"
}
resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id = module.vpc_module.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "server" {
  count = var.instance_count

  ami           = "ami-080d1454ad4fabd12"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id = module.vpc_module.subnet_id

  availability_zone = element(random_shuffle.az.result, count.index)

  tags = {
    Name = "server${count.index + 1}"
  }
}
