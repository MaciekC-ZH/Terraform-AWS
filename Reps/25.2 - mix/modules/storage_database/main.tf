resource "aws_s3_bucket" "this" {
  for_each      = var.tables
  bucket        = "db-table-${each.key}-${var.env_name}-2026"
  force_destroy = true
  tags = {
    TableName    = each.key                       #nie miałem podczas nauki
    StorageClass = each.value.storage_class       #nie miałem podczas nauki
    Encrypted    = tostring(each.value.encrypted) #nie miałem podczas nauki
    Environment  = var.env_name
  }
}
