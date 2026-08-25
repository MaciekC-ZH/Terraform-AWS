terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = merge(
    var.common_tags,
    {
        Name = "stage-vpc"
    }
  )
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true
  tags = merge(
    var.common_tags,
    {
        Name = "stage-public-subnet"
    }
  )
}
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = "eu-central-1b"
  map_public_ip_on_launch = false
  tags = merge(
    var.common_tags,
    {
        Name = "stage-private-subnet"
    }
  )
}
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(
    var.common_tags,
    {
        Name = "stage-igw"
    }
  )
}
resource "aws_eip" "eip" {
  domain = "vpc"
  depends_on = [ aws_internet_gateway.main_igw ]
  tags = merge(
    var.common_tags,
    {
        Name = "stage-nat-eip"
    }
)
}
resource "aws_nat_gateway" "main_nat" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public_subnet.id
  tags = merge(
    var.common_tags,
    {
        Name = "stage-nat-gw"
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
        Name = "stage-public-rt"
    }
  )
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main_nat.id
    
  }
  tags = merge(
    var.common_tags,
    {
        Name = "stage-private-rt"
    }
  )
}
resource "aws_route_table_association" "pub_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "priv-tr-asso" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id

}