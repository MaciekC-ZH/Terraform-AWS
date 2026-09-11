output "subnets_ids" {
  value = { for key, value in aws_subnet.this : key => value.id }
}
