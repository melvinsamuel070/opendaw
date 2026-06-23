variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_name" {
  type    = string
  default = "opendaw-production-ec2" # 👈 Added default fallback value
}

variable "instance_type" {
  type    = string
  default = "t3.micro"               # 👈 Added default fallback value
}

variable "key_name" {
  type    = string
  default = "git1"         # 👈 Replace with your exact AWS Key Pair name
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "architecture" {
  type    = string
  default = "x86"
}