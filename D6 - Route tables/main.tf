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

# 1. VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.project_tags,
    {
      Name = "routing-vpc-dev"
    }
  )
}

# 2. Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = merge(
    var.project_tags,
    {
      Name = "public-subnet-1a"
    }
  )
}

# 3. Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false

  tags = merge(
    var.project_tags,
    {
      Name = "private-subnet-1a"
    }
  )
}

# 4. Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(
    var.project_tags,
    {
      Name = "main-igw"
    }
  )
}

# 5. NOWOŚĆ: Publiczna Tabela Routingu (Drogowskaz na swiat)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = merge(
    var.project_tags,
    {
      Name = "public-route-table"
    }
  )
}

# 6. NOWOŚĆ: Połączenie (Asocjacja) Public Subnetu z Publiczną Tabelą Routingu
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
