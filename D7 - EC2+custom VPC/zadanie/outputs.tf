output "public_server_public_ip" {
  value = aws_instance.public_web_ec2.public_ip

}
output "public_server_private_ip" {
  value = aws_instance.public_web_ec2.private_ip

}
output "private_server_private_ip" {
  value = aws_instance.private_web_ec2.private_ip
}
