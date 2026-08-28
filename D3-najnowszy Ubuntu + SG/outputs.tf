output "server_public_ip" {
  description = "Publiczny adres IP maszyny EC2"
  value       = aws_instance.my_web_server.public_ip
}

output "server_id" {
  description = "Identyfikator instancji EC2"
  value       = aws_instance.my_web_server.id
}

output "ami_used_id" {
  description = "ID obrazu AMI pobranego automatycznie przez Data Source"
  value       = data.aws_ami.latest_ubuntu.id
}