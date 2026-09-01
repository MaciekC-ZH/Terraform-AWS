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

# 1. Bucket S3 na plik stanu
resource "aws_s3_bucket" "terraform_state" {
  bucket        = var.bucket_name
  force_destroy = true # Pozwala na łatwe usunięcie bucketa z plikami podczas nauki

  tags = {
    Name        = "Terraform State Storage"
    Environment = "Global"
  }
}

# 2. Włączenie wersjonowania (pozwala odzyskać stary stan w razie awarii)
resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 3. Szyfrowanie pliku stanu po stronie serwera (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "state_encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# 4. Blokada publicznego dostępu do bucketa
resource "aws_s3_bucket_public_access_block" "state_public_block" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 5. Tabela DynamoDB do blokowania stanu (State Locking)
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID" # 👈 Klucz MUSI nazywać się dokładnie "LockID" (wymóg Terraforma)

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Lock Table"
    Environment = "Global"
  }
}
