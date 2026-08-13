terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region

}

data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_security_group" "moja-sg" {
  name        = "konsolidacja-02-sg"
  description = "Pozwolenie na in 22 i 8080 + full egress"

  ingress {
    description = "ssh"
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "other"
    to_port     = 8080
    from_port   = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "moj-server" {
  ami                    = data.aws_ami.latest_ubuntu.id
  tags                   = var.project_tags
  key_name               = var.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.moja-sg.id]
}
