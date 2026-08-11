output "ec2_public_ip" {
  description = "Publiczne IP"
  value       = aws_instance.konsolidacja_ec2.public_ip
}

output "ec2_instance_id" {
  description = "ID instancji EC2"
  value       = aws_instance.konsolidacja_ec2.id
}
