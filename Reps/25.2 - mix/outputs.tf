output "all_table_ids" {
  value = module.database.table_bucket_ids
}
output "audit_bucket_name" {
  value = length(aws_s3_bucket.audit_logs) > 0 ? aws_s3_bucket.audit_logs[0].bucket : "Brak audytu dla środowiska"
}
