output "public_ip" {
  value = aws_instance.moj-server.public_ip
}
output "sg_id" {
  value = aws_security_group.moja-sg.id
}
