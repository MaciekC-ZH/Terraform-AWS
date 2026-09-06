output "audit_bucket_name" {
  value = length(aws_s3_bucket.security_audit_bucket) > 0 ? aws_s3_bucket.security_audit_bucket[0].bucket : "Audyt jest wyłączony"

}
output "creted_subnets_ids" {
  value = { for key, subnet in aws_subnet.managed_subnets : key => subnet.id }

}



# output "server_ips" {
#   value = { for key, info in aws_instance.servers : key => info.public_ip}
# }
# output "server_arns_list" {
#   value = [ for i in aws_instance.servers : i.arn]
# }
