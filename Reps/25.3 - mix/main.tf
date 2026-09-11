locals {
  network_by_env = {
    dev = {
      app = {
        cidr_block = "10.0.1.0/24"
        is_public  = false
      }
    }
    prod = {
      app = {
        cidr_block = "10.0.1.0/24"
        is_public  = false
      }
      dmz = {
        cidr_block = "10.0.2.0/24"
        is_public  = true
      }
    }
  }
  current_config = lookup(local.network_by_env, terraform.workspace, local.network_by_env["dev"])
}
module "network" {
  source         = "./modules/network_subnets"
  vpc_id         = "vpc-0123456789abcdef0"
  subnets_config = local.current_config
  env_name       = terraform.workspace
}
resource "aws_internet_gateway" "gw" {
  count  = terraform.workspace == "prod" ? 1 : 0
  vpc_id = "vpc-0123456789abcdef0"
  tags = {
    Name = "igw-${terraform.workspace}"
  }
}
