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

# 1. Pobranie AMI Ubuntu
data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# 2. VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.project_tags,
    {
      Name = "custom-vpc"
    }
  )
}

# 3. Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = merge(
    var.project_tags,
    {
      Name = "public-subnet-web"
    }
  )
}

# 4. Internet Gateway
resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = merge(
    var.project_tags,
    {
      Name = "custom-igw"
    }
  )
}

# 5. Route Table + Asocjacja
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_igw.id
  }

  tags = merge(
    var.project_tags,
    {
      Name = "public-rt"
    }
  )
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# 6. NOWOŚĆ: Security Group przypisana do naszego VPC
resource "aws_security_group" "web_sg" {
  name        = "custom-vpc-web-sg"
  description = "Pozwol na SSH oraz HTTP"
  vpc_id      = aws_vpc.custom_vpc.id # 👈 KLUCZOWE: SG musi wiedziec, w ktorym VPC sie znajduje!

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.project_tags,
    {
      Name = "web-sg"
    }
  )
}

# 7. NOWOŚĆ: Maszyna EC2 postawiona we wlasnym subnecie
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public_subnet.id # 👈 KLUCZOWE: Umieszczamy EC2 w Public Subnecie!
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = merge(
    var.project_tags,
    {
      Name = "web-server-custom-vpc"
    }
  )
}
