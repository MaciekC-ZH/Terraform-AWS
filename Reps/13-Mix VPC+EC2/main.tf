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
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    var.common_tags,
    {
      Name = "final-vpc"
    }
  )
}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true
  tags = merge(
    var.common_tags,
    {
      Name = "final-public-subnet"
    }
  )
}
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false
  tags = merge(
    var.common_tags,
    {
      Name = "final-private-subnet"
    }
  )
}
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(
    {
      Name = "final-igw"
    }
  )
}
resource "aws_eip" "eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.main_igw]
  tags = merge(
    var.common_tags,
    {
      Name = "final-nat-eip"
    }
  )
}
resource "aws_nat_gateway" "main_nat" {
  subnet_id     = aws_subnet.public_subnet.id
  allocation_id = aws_eip.eip.id
  tags = merge(
    var.common_tags,
    {
      Name = "final-nat-igw"
    }
  )
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
  tags = merge(
    var.common_tags,
    {
      Name = "final-public-rt"
    }
  )
}
resource "aws_route_table_association" "public_rt_assoc" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_nat.id
  }
  tags = merge(
    var.common_tags,
    {
      Name = "final-private-rt"
    }
  )
}
resource "aws_route_table_association" "private_rt_assoc" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private_subnet.id
}

resource "aws_security_group" "main_sg" {
  vpc_id = aws_vpc.main_vpc.id
  ingress {
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    to_port     = 80
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    var.common_tags,
    {
      Name = "final-main-sg"
    }
  )
}
resource "aws_instance" "ec2_web_server" {
  ami                    = data.aws_ami.latest_ubuntu.id
  subnet_id              = aws_subnet.public_subnet.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  user_data              = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>Final Boss pokonany!</h1>" > /var/www/html/index.html
              EOF
  tags = merge(
    var.common_tags,
    {
      Name = "final-public-webserver"
    }
  )
}
resource "aws_instance" "ec2_private_db_server" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  tags = merge(
    var.common_tags,
    {
      Name = "final-private-db"
    }
  )
}
