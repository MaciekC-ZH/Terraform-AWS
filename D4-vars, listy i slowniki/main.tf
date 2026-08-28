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

resource "aws_security_group" "demo_sg" {
  name        = "tfvars-demo-sg"
  description = "Demo SG z uzyciem zmiennych typu list i map"

  # Port 1 z naszej listy (22)
  ingress {
    from_port   = var.ingress_ports[0]
    to_port     = var.ingress_ports[0]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 2 z naszej listy (80)
  ingress {
    from_port   = var.ingress_ports[1]
    to_port     = var.ingress_ports[1]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Przypisujemy całą mapę tagów z pliku .tfvars!
  tags = var.project_tags
}