variable "aws_region" {
  description = "Region dla zaobów"
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "Typ instancji EC"
  type        = string
  default     = "t3.micro"
}

variable "project_tags" {
  description = "Domyslne tagi"
  type        = map(string)
  default = {
    Owner       = "Maciek"
    Project     = "Konsolidacja"
    Environment = "Dev"
  }

}
