output "dev_server_ip" {
  value = module.dev_web_server.public_ip
}

output "prod_server_ip" {
  value = module.prod_web_server.public_ip
}
