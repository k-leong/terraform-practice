variable "subnet" {
  type = list(string)
}

variable "instance_count" {
  default = 5
}

variable "ec2_security_group" {
  type = string
}