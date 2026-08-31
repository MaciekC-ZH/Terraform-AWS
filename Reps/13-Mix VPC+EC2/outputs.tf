output "vpc_id" {
  value = aws_vpc.main_vpc.id
}
output "web_public_ip" {
  value = aws_instance.ec2_web_server.public_ip
}
output "web_url" {
  value = "http://${aws_instance.ec2_web_server.public_ip}"
}
output "private_db_ip" {
  value = aws_instance.ec2_private_db_server.private_ip
}
output "nat_public_ip" {
  value = aws_eip.eip.public_ip
}
