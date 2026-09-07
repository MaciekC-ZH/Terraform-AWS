resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    "Name"        = var.bucket_name,
    "Environment" = var.env_tag
  }
}
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}
