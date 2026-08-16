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
        Name = "1ab-public-subnet"
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
            Name = "1ab-public-subnet"
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
            Name = "1ab-private-subnet"
        }
    )
}
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(
    var.common_tags,
    {
        Name = "1ab-igw"
    }
  )
}
resource "aws_route_table" "main_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
    
  }
  tags = merge(
    var.common_tags,
    {
        Name = "1ab-public-rt"
    }
  )
}
resource "aws_route_table_association" "table_asso" {
  route_table_id = aws_route_table.main_table.id
  subnet_id = aws_subnet.public_subnet.id
}