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
data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}
resource "aws_security_group" "final-sg" {
  name        = "final-boss-sg"
  description = "Pozwolenie na 22, 80, 443 i pełny ergress"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    to_port     = 0
    from_port   = 0

  }
}
resource "aws_instance" "final-ec" {
  ami                    = data.aws_ami.latest_ubuntu.id
  vpc_security_group_ids = [aws_security_group.final-sg.id]
  instance_type          = var.instance_type
  key_name               = var.key_name
  tags                   = var.common_tags
}
resource "aws_s3_bucket" "final-koszyk" {
  tags   = var.common_tags
  bucket = var.bucket_name
}
