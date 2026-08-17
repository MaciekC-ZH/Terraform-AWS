
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

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type    = string
  default = "klucz-aws-frankfurt" # Podaj nazwę swojego klucza SSH
}

variable "project_tags" {
  type = map(string)
  default = {
    Owner       = "Maciek-DevOps"
    Project     = "EC2-in-Custom-VPC"
    Environment = "Dev"
  }
}
