variable "aws_region" {
  type = string
  default = "eu-central-1"
}
variable "vpc_cidr" {
  type = string
  default = "10.100.0.0/16"
}
variable "public_subnet_a_cidr" {
  type = string
  default = "10.100.1.0/24"
}
variable "public_subnet_b_cidr" {
  type = string
  default = "10.100.2.0/24"
}
variable "common_tags" {
  type = map(string)
  default = {
    "Owner" = "Maciek"
    "Project" = "Consolidation-1"
    "Environment" = "Dev"
  }
}