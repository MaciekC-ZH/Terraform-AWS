output "configured_subnets" {
  value = module.network.subnets_ids
}
output "getaway_id" {
  value = length(aws_internet_gateway.gw) > 0 ? aws_internet_gateway.gw[0].id : "Brak IGW na tym srodowisku"
}
