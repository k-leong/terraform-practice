resource "aws_instance" "server" {
  ami             = "ami-080d1454ad4fabd12"
  instance_type   = "t2.micro"
  subnet_id       = var.subnet
  security_groups = [var.ec2_security_group]
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
    Name = "tf server"
  }
}