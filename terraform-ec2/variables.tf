variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "architecture" {
  type    = string
  default = "x86"
}