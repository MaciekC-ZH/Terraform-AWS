
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

# 1. Tworzenie glownego VPC (Wlasne odizolowane osiedle)
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.project_tags,
    {
      Name = "custom-vpc-dev"
    }
  )
}

# 2. Tworzenie Public Subnetu (Dla serwerow WWW)
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true # Automatycznie przydziela publiczne IP maszynom w tym subnecie!

  tags = merge(
    var.project_tags,
    {
      Name = "public-subnet-1a"
    }
  )
}

# 3. Tworzenie Private Subnetu (Dla baz danych)
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false # Zakaz publicznego IP! Pelna izolacja.

  tags = merge(
    var.project_tags,
    {
      Name = "private-subnet-1a"
    }
  )
}

# 4. Tworzenie Internet Gateway (Brama na swiat dla calego VPC)
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(
    var.project_tags,
    {
      Name = "main-igw"
    }
  )
}