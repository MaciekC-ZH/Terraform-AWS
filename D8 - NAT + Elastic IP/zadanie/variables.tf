variable "aws_region" {
  type = string
  default = "eu-central-1"
}
variable "vpc_cidr" {
  type = string
  default = "172.20.0.0/16"
}
variable "public_subnet_cidr" {
  type = string
  default = "172.20.1.0/24"
}
variable "private_subnet_cidr" {
  type = string
  default = "172.20.2.0/24"
}
variable "common_tags" {
  type = map(string)
  default = {
    "Owner" = "Maciek"
    "Project" = "Standalone-NAT"
    "Environment" = "Stage"
  }
}