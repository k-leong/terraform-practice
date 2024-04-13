output "ec2_ami" {
  value = aws_instance.server.ami
}

output "ec2_instance_type" {
  value = aws_instance.server.instance_type
}

output "ec2_user_data" {
  value = aws_instance.server.user_data
}