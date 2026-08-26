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
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = merge(
    var.common_tags,
    {
        Name = "multiaz-vpc"
    }
  )
}
resource "aws_subnet" "public_subnet_a" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_a_cidr
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true
  tags = merge(
    var.common_tags,
    {
        Name = "multiaz-public-subnet-1a"
    }
  )
}
resource "aws_subnet" "public_subnet_b" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_b_cidr
  availability_zone = "eu-central-1b"
  map_public_ip_on_launch = true
  tags = merge(
    var.common_tags,
    {
        Name = "multiaz-public-subnet-1b"
    }
  )
}
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(
    var.common_tags,
    {
        Name = "multiaz-igw"
    }
  )
}
resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
  tags = merge(
    var.common_tags,
    {
        Name = "multiaz-public-rt"
    }
  )
}
resource "aws_route_table_association" "rt_assoc_a" {
  subnet_id = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.main_rt.id
}
resource "aws_route_table_association" "rt_assoc_b" {
  subnet_id = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.main_rt.id
}