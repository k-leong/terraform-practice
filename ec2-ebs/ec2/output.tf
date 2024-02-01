output "ec2_instance_id" {
  value = aws_instance.server[*].id
}

output "ec2_instance_az" {
  value = aws_instance.server[*].availability_zone
}