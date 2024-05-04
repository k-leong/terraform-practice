variable "min_size" {
  default = 1
  type    = number
}

variable "max_size" {
  default = 10
  type    = number
}

variable "elb" {
  type = string
}

variable "vpc_subnets" {
  type = list(string)
}

variable "target_group" {
  type = string
}

variable "instance_sg" {
  type = string
}