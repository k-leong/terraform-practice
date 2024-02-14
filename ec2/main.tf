data "aws_ami" "al2023" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}

resource "aws_instance" "test_peer" {
  ami             = data.aws_ami.al2023.id
  instance_type   = "t3.micro"
  security_groups = [var.peer_sg_id]
  subnet_id       = var.peer_subnet_id
  user_data       = <<EOF
    #!/bin/bash
    # Use this for your user data (script from top to bottom)
    # install httpd (Linux 2 version)
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name = "test peer"
  }
}

resource "aws_instance" "test" {
  ami             = data.aws_ami.al2023.id
  instance_type   = "t3.micro"
  security_groups = [var.sg_id]
  subnet_id       = var.subnet_id
  user_data       = <<EOF
    #!/bin/bash
    # Use this for your user data (script from top to bottom)
    # install httpd (Linux 2 version)
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name = "test"
  }
}