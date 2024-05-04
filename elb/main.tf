resource "aws_lb" "test" {
  name               = "terraform-test-elb"
  load_balancer_type = "application"

  subnets = [for subnet in var.subnets : subnet]

  tags = {
    Environment = "test"
  }
}

resource "aws_lb_target_group" "test_target_group" {
  name     = "terraform-test-target-group"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = var.vpc
}
