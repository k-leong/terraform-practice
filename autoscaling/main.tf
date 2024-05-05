resource "aws_autoscaling_group" "tf_autoscale" {
  name              = "terraform-test-autoscaling"
  min_size          = var.min_size
  max_size          = var.max_size
  health_check_type = "ELB"
  force_delete      = true
  launch_template {
    id      = aws_launch_template.tf_launch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier = var.vpc_subnets
  target_group_arns   = [var.target_group]
}

resource "aws_launch_template" "tf_launch_template" {
  instance_type = "t2.micro"
  image_id      = "ami-080d1454ad4fabd12"
  key_name      = "terraform"
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups = [ var.instance_sg ]
  }
  user_data = (base64encode(<<EOF
    #!/bin/bash
    # Use this for your user data (script from top to bottom)
    # install httpd (Linux 2 version)
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
  EOF
  ))

  # vpc_security_group_ids = [var.instance_sg]
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "terraform test instance"
    }
  }

  tags = {
    Name = "terraform launch template"
  }
}

resource "aws_autoscaling_attachment" "tf_autoscale_att" {
  autoscaling_group_name = aws_autoscaling_group.tf_autoscale.id
  lb_target_group_arn    = var.target_group
}
