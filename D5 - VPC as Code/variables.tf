variable "aws_region" {
  description = "Region AWS, w ktorym tworzymy infrastrukture"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  description = "Glowna przestrzen adresowa dla naszego VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Przestrzen adresowa dla Public Subnetu"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Przestrzen adresowa dla Private Subnetu"
  type        = string
  default     = "10.0.2.0/24"
}

variable "project_tags" {
  description = "Wspolne tagi dla zasobow sieciowych"
  type        = map(string)
  default = {
    Owner       = "Maciek-DevOps"
    Project     = "Custom-VPC"
    Environment = "Dev"
  }
}