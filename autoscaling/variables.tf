variable "min_size" {
  default = 1
  type = number
}

variable "max_size" {
  default = 10
  type = number
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "user_data" {
  type = string
}