output "vpc_id" {
  value = aws_vpc.main_vpc.id
}
output "web_server_public_ip" {
  value = aws_instance.main_ec.public_ip
}
output "website_url" {
  value = "http://${aws_instance.main_ec.public_ip}"
}
