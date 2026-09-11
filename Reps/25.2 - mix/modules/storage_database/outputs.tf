output "table_bucket_ids" {
  value = { for key, value in aws_s3_bucket.this : key => value.id }
}
