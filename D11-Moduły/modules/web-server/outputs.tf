output "instance_id" {
  value       = aws_instance.web_instance.id
  description = "ID utworzonej instancji"
}

output "public_ip" {
  value       = aws_instance.web_instance.public_ip
  description = "Publiczny adres IP instancji"
}
