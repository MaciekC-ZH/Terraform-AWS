terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

# Mapa konfiguracji per środowisko
locals {
  env = terraform.workspace

  instance_type = {
    default = "t3.micro"
    dev     = "t3.micro"
    prod    = "t3.small"
  }

  bucket_prefix = {
    default = "default"
    dev     = "dev"
    prod    = "prod"
  }
}

# Dynamiczny bucket S3
resource "aws_s3_bucket" "workspace_bucket" {
  # Nazwa uzależniona od aktywnego workspace'u
  bucket        = "maciek-ws-${lookup(local.bucket_prefix, local.env, "dev")}-storage-2026"
  force_destroy = true

  tags = {
    Name        = "Storage-${local.env}"
    Environment = local.env
  }
}
