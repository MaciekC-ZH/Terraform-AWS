output "ec2_public_ip" {
  description = "Publiczny adres IP maszyny w Custom VPC"
  value       = aws_instance.web_server.public_ip
}

output "ec2_private_ip" {
  description = "Prywatny adres IP maszyny z puli 10.0.1.x"
  value       = aws_instance.web_server.private_ip
}
