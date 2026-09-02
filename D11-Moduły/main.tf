terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Pobieramy najnowsze Ubuntu dla modułów
data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# 🚀 Wywołanie modułu 1: Serwer DEV
module "dev_web_server" {
  source = "./modules/web-server" # Ścieżka lokalna do folderu modułu

  ami_id        = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"
  server_name   = "dev-app-server"
  environment   = "dev"
}

# 🚀 Wywołanie modułu 2: Serwer PROD (ten sam kod modułu, inne parametry!)
module "prod_web_server" {
  source = "./modules/web-server"

  ami_id        = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.small"
  server_name   = "prod-app-server"
  environment   = "prod"
}
