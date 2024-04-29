resource "aws_autoscaling_group" "tf_autoscale" {
  name                 = "terraform-test-autoscaling"
  min_size             = var.min_size
  max_size             = var.max_size
  health_check_type    = "ELB"
  force_delete         = true
  launch_template {
    id      = aws_launch_template.tf_launch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier  = var.vpc_subnets
  target_group_arns    = [var.target_group]
}

resource "aws_launch_template" "tf_launch_template" {
  instance_type = var.instance.instance_type
  image_id = var.instance.ami
  user_data = var.instance.user_data
  vpc_security_group_ids = [ var.instance_sg ]

  tags = {
    Name = "terraform launch template"
  }
}

resource "aws_autoscaling_attachment" "tf_autoscale_att" {
  autoscaling_group_name = aws_autoscaling_group.tf_autoscale.id
  lb_target_group_arn   = var.target_group
}
