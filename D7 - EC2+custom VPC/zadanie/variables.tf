variable "aws_region" {
  type    = string
  default = "eu-central-1"
}
variable "vpc_cidr" {
  type    = string
  default = "10.50.0.0/16"
}
variable "public_subnet_cidr" {
  type    = string
  default = "10.50.1.0/24"
}
variable "private_subnet_cidr" {
  type    = string
  default = "10.50.2.0/24"
}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "key_name" {
  type    = string
  default = "klucz-aws-frankfurt"
}
variable "common_tags" {
  type = map(string)
  default = {
    "Owner"       = "Maciek"
    "Project"     = "VPC-EC2-Standalone"
    "Environment" = "Dev"
  }
}
