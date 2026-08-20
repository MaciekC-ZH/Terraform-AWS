variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "project_tags" {
  type = map(string)
  default = {
    Owner       = "Maciek-DevOps"
    Project     = "NAT-Architecture"
    Environment = "Dev"
  }
}
