resource "aws_subnet" "this" {
  for_each   = var.subnets_config
  vpc_id     = var.vpc_id
  cidr_block = each.value.cidr_block
  tags = {
    "Name"        = "subnet-${each.key}-${var.env_name}"
    "Public"      = tostring(each.value.is_public)
    "Environment" = var.env_name
  }
}
