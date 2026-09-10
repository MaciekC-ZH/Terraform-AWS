resource "aws_instance" "this" {
  for_each      = var.cluster_nodes
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = each.value.instance_type
  tags = {
    "Name"        = "server-${each.key}-${var.environment}"
    "Role"        = "${each.value.role}"
    "Environment" = var.environment
  }
}
