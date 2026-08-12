terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = var.aws_region
}
resource "aws_s3_bucket" "dev-s3-2026" {
  bucket = var.bucket_prefix
  tags   = var.env_tags
}
