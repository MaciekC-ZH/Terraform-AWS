output "cluster_server_ids" {
  value = module.app_cluster.instance_ids
}
output "backup_bucket_status" {
  value = length(aws_s3_bucket.backup) > 0 ? aws_s3_bucket.backup[0].bucket : "Brak bucketa backupu dla tego srodowiska"
}
