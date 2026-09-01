variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "environment" {
  type        = string
  default     = "dev" # Zmienimy na "prod" w ramach testów warunku
  description = "Środowisko: dev, stage lub prod"
}

variable "subnets_config" {
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {
    "subnet-a" = { cidr = "10.0.1.0/24", az = "eu-central-1a" }
    "subnet-b" = { cidr = "10.0.2.0/24", az = "eu-central-1b" }
    "subnet-c" = { cidr = "10.0.3.0/24", az = "eu-central-1c" }
    "subnet-d" = { cidr = "10.0.4.0/24", az = "eu-central-1a" }
  }
}

variable "instance_count" {
  type    = number
  default = 3
}
