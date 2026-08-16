variable "aws_region" {
  type = string
  default = "eu-central-1"
}
variable "vpc_cidr" {
  type = string
  default = "192.168.0.0/16"
}
variable "public_subnet_cidr" {
  type = string
  default = "192.168.10.0/24"
}
variable "private_subnet_cidr" {
  type = string
  default = "192.168.20.0/24"
}
variable "common_tags" {
  type = map(string)
  default = {
    "Owner" = "Maciek"
    "Project" = "Standalone-routing"
    "Environment" = "testing"
  }
}