variable "aws_region" {
  description = "Region AWS"
  type        = string
  default     = "eu-central-1"
}

variable "bucket_prefix" {
  description = "Bucket S3"
  type        = string
  default     = "moj-bucket-testowy"
}

variable "env_tags" {
  type = map(string)
  default = {
    "Owner" = "Maciek"
    "Env"   = "Dev"
  }
}
