resource "aws_lb" "test" {
  name               = "terraform-test-elb"
  load_balancer_type = "application"

  subnets = [for subnet in var.subnets : subnet]

  tags = {
    Environment = "test"
  }
}