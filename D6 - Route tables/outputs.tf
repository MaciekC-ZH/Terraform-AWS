output "vpc_id" {
  description = "ID utworzonego VPC"
  value       = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
  description = "ID podsieci publicznej"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "ID podsieci prywatnej"
  value       = aws_subnet.private_subnet.id
}

output "internet_gateway_id" {
  description = "ID bramy Internet Gateway"
  value       = aws_internet_gateway.main_igw.id
}

output "public_route_table_id" {
  description = "ID tabeli routingu dla publicznego subnetu"
  value       = aws_route_table.public_rt.id
}
