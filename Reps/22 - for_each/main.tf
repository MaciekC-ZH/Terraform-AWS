resource "aws_s3_bucket" "storage" {
  for_each      = var.app_storage
  bucket        = "maciek-${each.key}-storage-2026"
  force_destroy = each.value.force_destroy
  tags = {
    "Name" = "Storage for ${each.key}"
  }
}
