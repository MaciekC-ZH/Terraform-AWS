# Zwracanie mapy ID subnetów za pomocą pętli for w outputach
output "subnet_ids" {
  value = { for key, subnet in aws_subnet.dynamic_subnets : key => subnet.id }
}

# Zwracanie listy prywatnych IP instancji stworzonych przez count
output "instance_private_ips" {
  value = aws_instance.workers[*].private_ip
}

# Zwracanie ID bucketa jeśli istnieje, lub null jeśli count = 0
output "prod_bucket_name" {
  value = length(aws_s3_bucket.prod_backup_bucket) > 0 ? aws_s3_bucket.prod_backup_bucket[0].bucket : "Brak bucketa (nie jestesmy na prodzie)"
}
