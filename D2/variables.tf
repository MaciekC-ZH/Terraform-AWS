variable "aws_region" {
  description = "Region AWS, w ktorym tworzymy zasoby"
  type        = string
  default     = "eu-central-1"
}

variable "bucket_name" {
  description = "Unikalna nazwa dla Bucketa S3"
  type        = string
  default     = "maciek-devops-variables-test-2026" # ⚠️ Zmień na swoją unikalną nazwę!
}

variable "environment" {
  description = "Srodowisko uruchomieniowe (Dev, Staging, Prod)"
  type        = string
  default     = "Dev"
}