variable "aws_region" {
  description = "Region AWS"
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "Typ instancji EC2"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Nazwa Twojego klucza SSH w AWS"
  type        = string
  default     = "klucz-aws-frankfurt" # ⚠️ Podmień na nazwę swojego klucza SSH z AWS!
}