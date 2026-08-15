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
        Name = "staging-custom-vpc"
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
        Name = "staging-public-vpc"
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
        Name = "staging-private-vpc"
    }
  )
}
resource "aws_internet_gateway" "aws_internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(
    var.common_tags,
    {
        Name = "staging-igw"
    }
  )
}
