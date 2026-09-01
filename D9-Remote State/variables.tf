variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "bucket_name" {
  type    = string
  default = "maciek-devops-tfstate-2026-backend" # 👈 Zmień na unikalną nazwę
}

variable "dynamodb_table_name" {
  type    = string
  default = "terraform-state-locks"
}
