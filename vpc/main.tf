resource "aws_vpc" "terraform_test" {
  cidr_block = "172.30.0.0/16"

  tags = {
    Name="terraform test"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.terraform_test.id
  cidr_block = "172.30.0.0/24"
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
# resource "aws_security_group" "allow_ssh" {
#   name = "allow_ssh"
#   description = "Allow SSH inbound traffic"
#   vpc_id = aws_vpc.terraform_test.id

#   ingress {
#     description = "SSH from VPC"
#     from_port = 22
#     to_port = 22
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# output "sg_id" {
#   value = aws_security_group.allow_ssh.id
# }