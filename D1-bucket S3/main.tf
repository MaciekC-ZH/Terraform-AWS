# 1. Konfiguracja wymaganego dostawcy (Providera)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# 2. Konfiguracja Połączenia z AWS
provider "aws" {
  region = "eu-central-1" # Frankfurt
}

# 3. Deklaracja Zasobu (Resource): Bucket S3
resource "aws_s3_bucket" "my_first_bucket" {
  bucket = "maciek-devops-terraform-bucket-2026-test" # ⚠️ Zmień tę nazwę na swoją unikalną!

  tags = {
    Name        = "MyFirstTerraformBucket"
    Environment = "Learning"
    Owner       = "Maciek"
  }
}