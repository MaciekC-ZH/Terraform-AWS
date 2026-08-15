output "vpc_id" {
  description = "ID glownego VPC"
  value       = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
  description = "ID publicznej podsieci"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "ID prywatnej podsieci"
  value       = aws_subnet.private_subnet.id
}

output "internet_gateway_id" {
  description = "ID bramy internetowej"
  value       = aws_internet_gateway.main_igw.id
}