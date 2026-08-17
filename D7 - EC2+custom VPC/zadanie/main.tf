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
      Name = "standalone-vpc"
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
      Name = "standalone-public-subnet"
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
      Name = "standalone-private-subnet"
    }
  )
}
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(
    var.common_tags,
    {
      Name = "standalone-igw"
    }
  )
}
resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }
}
resource "aws_route_table_association" "main_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.main_rt.id
}
resource "aws_security_group" "main_sg" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "main-vpc-web-sg"
  description = "Otwarte porty 22 oraz 80"

  ingress {
    description = "SSH"
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http"
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
}
resource "aws_instance" "public_web_ec2" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  tags = merge(
    var.common_tags,
    {
      Name = "public-web-server"
    }
  )
}

resource "aws_instance" "private_web_ec2" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  tags = merge(
    var.common_tags,
    {
      Name = "private-db-server"
    }
  )
}
