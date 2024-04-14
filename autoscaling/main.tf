resource "aws_autoscaling_group" "tf_autoscale" {
  name                 = "terraform-test-autoscaling"
  min_size             = var.min_size
  max_size             = var.max_size
  health_check_type    = "ELB"
  force_delete         = true
  launch_configuration = aws_launch_configuration.tf_launch.name
}

resource "aws_launch_configuration" "tf_launch" {
  instance_type = var.instance_type
  image_id      = var.ami
  user_data     = var.user_data
}

resource "aws_autoscaling_attachment" "tf_autoscale_att" {
  autoscaling_group_name = aws_autoscaling_group.tf_autoscale.id
  elb                    = var.elb
}
