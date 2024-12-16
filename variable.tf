variable "aws_region" {
  type    = string
  default = "us-west-1"
}

variable "bank_cidrs" {
  type    = list(any)
  default = ["10.0.0.0/8", "192.168.164.0/23", "22.0.0.0/8"]
}

