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

resource "aws_s3_bucket" "my_variable_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "Bucket-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}