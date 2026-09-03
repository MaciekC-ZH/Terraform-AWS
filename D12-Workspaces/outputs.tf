output "active_workspace" {
  value = terraform.workspace
}

output "created_bucket_name" {
  value = aws_s3_bucket.workspace_bucket.bucket
}
