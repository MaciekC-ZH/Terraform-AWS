variable "aws_region" {
  type    = string
  default = "eu-central-1"
}
variable "vpc_cidr" {
  type    = string
  default = "10.250.0.0/16"
}
variable "public_subnet_cidr" {
  type    = string
  default = "10.250.1.0/24"
}
variable "private_subnet_cidr" {
  type    = string
  default = "10.250.2.0/24"
}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "common_tags" {
  type = map(string)
  default = {
    "Owner"       = "Maciek"
    "Project"     = "conso-final"
    "Environment" = "Dev"
  }
}
