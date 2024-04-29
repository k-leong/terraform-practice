output "elb" {
  value = aws_lb.test.id
}

output "target_group" {
  value = aws_lb_target_group.test_target_group
}