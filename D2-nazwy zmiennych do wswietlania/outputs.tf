output "bucket_arn" {
  description = "Unikalny identyfikator ARN utworzonego Bucketa"
  value       = aws_s3_bucket.my_variable_bucket.arn
}

output "bucket_domain_name" {
  description = "Pełny adres domenowy Bucketa S3"
  value       = aws_s3_bucket.my_variable_bucket.bucket_regional_domain_name
}