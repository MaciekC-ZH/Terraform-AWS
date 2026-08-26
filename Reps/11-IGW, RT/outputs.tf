output "vpc_id" {
  value = aws_vpc.main_vpc.id
}
output "public_subnet_a_id" {
  value = aws_subnet.public_subnet_a.id
}
output "public_subnet_b_id" {
  value = aws_subnet.public_subnet_b.id
}
output "igw_id" {
  value = aws_internet_gateway.main_igw.id
}
output "public_rt_id" {
  value = aws_route_table.main_rt.id
}