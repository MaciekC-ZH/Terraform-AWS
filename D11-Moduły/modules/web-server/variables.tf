variable "ami_id" {
  type        = string
  description = "ID obrazu AMI dla serwera"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Typ instancji EC2"
}

variable "server_name" {
  type        = string
  description = "Nazwa serwera w tagu Name"
}

variable "environment" {
  type        = string
  description = "Nazwa środowiska (dev/prod)"
}
