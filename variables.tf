variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "region" {
  default = "us-east-2"
}

variable "amis" {
  type = "map"

  default = {
    "us-east-2" = "ami-0de7daa7385332688"
    "us-west-2" = "ami-4b32be2b"
  }
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = "list"
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

#variable "azs" {
#  default = "us-east-2a"
#}

data "aws_availability_zones" "azs" {}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}
