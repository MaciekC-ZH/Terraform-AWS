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

# 1. DATA SOURCE: Pobieramy najnowszy oficjalny obraz Ubuntu 22.04 LTS
data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (twórcy Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# 2. RESOURCE: Grupa Bezpieczeństwa (Firewall)
resource "aws_security_group" "web_sg" {
  name        = "tf-web-security-group"
  description = "Zezwol na ruch SSH oraz HTTP"

  # Port 22 (SSH) dla administracji
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 80 (HTTP) dla ruchu sieciowego
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ruch wychodzący z serwera na cały świat (Egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TF-Web-SG"
  }
}

# 3. RESOURCE: Maszyna EC2
resource "aws_instance" "my_web_server" {
  ami                    = data.aws_ami.latest_ubuntu.id # 👈 Wykorzystanie pobranego ID z bloku data!
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id] # 👈 Przypisanie utworzonej grupy bezpieczeństwa!

  tags = {
    Name      = "TF-EC2-Server"
    ManagedBy = "Terraform"
  }
}