
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
      Name = "nat-vpc"
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

# 4. Internet Gateway (dla podsieci publicznej)
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(
    var.project_tags,
    {
      Name = "main-igw"
    }
  )
}

# 5. NOWOŚĆ: Elastic IP dla NAT Gateway
resource "aws_eip" "nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.main_igw] # EIP wymaga aktywnego IGW w VPC

  tags = merge(
    var.project_tags,
    {
      Name = "nat-eip"
    }
  )
}

# 6. NOWOŚĆ: NAT Gateway (musi stać w PUBLICZNYM subnecie!)
resource "aws_nat_gateway" "main_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = merge(
    var.project_tags,
    {
      Name = "main-nat-gw"
    }
  )

  depends_on = [aws_internet_gateway.main_igw]
}

# 7. Tabela routingu dla sieci PUBLICZNEJ (ruch 0.0.0.0/0 -> IGW)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
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

# 8. NOWOŚĆ: Tabela routingu dla sieci PRYWATNEJ (ruch 0.0.0.0/0 -> NAT Gateway)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_nat.id # 👈 Zauważ: nat_gateway_id zamiast gateway_id!
  }

  tags = merge(
    var.project_tags,
    {
      Name = "private-rt"
    }
  )
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}
