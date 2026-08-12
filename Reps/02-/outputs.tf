output "bucket_name" {
  description = "Nazwa bucketa"
  value       = aws_s3_bucket.dev-s3-2026.bucket

}

output "S3_arn" {
  description = "ARN dla utowrzonego S3"
  value       = aws_s3_bucket.dev-s3-2026.arn

}
