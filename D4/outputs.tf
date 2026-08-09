output "sg_id" {
  description = "ID utworzonej Security Group"
  value       = aws_security_group.demo_sg.id
}

output "applied_tags" {
  description = "Tagi nałożone z pliku .tfvars"
  value       = aws_security_group.demo_sg.tags_all
}

output "first_port" {
  description = "Pierwszy port z listy ingress_ports"
  value       = var.ingress_ports[0]
}