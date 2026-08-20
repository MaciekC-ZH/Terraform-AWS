output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "nat_public_ip" {
  description = "Publiczny adres IP przypisany do NAT Gateway"
  value       = aws_eip.nat_eip.public_ip
}

output "nat_gateway_id" {
  value = aws_nat_gateway.main_nat.id
}
