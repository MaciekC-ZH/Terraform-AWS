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

# 1. Główne VPC
resource "aws_vpc" "logic_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "logic-vpc"
    Environment = var.environment
  }
}

# 2. PĘTLA FOR_EACH: Tworzenie 3 subnetów na podstawie mapy
resource "aws_subnet" "dynamic_subnets" {
  for_each = var.subnets_config

  vpc_id            = aws_vpc.logic_vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name        = "logic-${each.key}"
    Environment = var.environment
  }
}

# 3. PĘTLA COUNT: Tworzenie instancji EC2
resource "aws_instance" "workers" {
  count = var.instance_count

  ami = data.aws_ami.latest_ubuntu.id
  # Dynamiczny dobór typu instancji: prod dostaje t3.small, reszta t3.micro
  instance_type = var.environment == "prod" ? "t3.small" : "t3.micro"

  # Wpinamy wszystkie maszyny do subnet-a (pobranego z for_each)
  subnet_id = aws_subnet.dynamic_subnets["subnet-a"].id

  tags = {
    Name        = "worker-node-${count.index + 1}"
    Environment = var.environment
  }
}

# 4. WARUNKOWY ZASÓB: Bucket S3 powstaje TYLKO na prodzie
resource "aws_s3_bucket" "prod_backup_bucket" {
  # Jeśli environment to prod, utwórz 1 bucket, w przeciwnym razie 0 (brak zasobu)
  count         = var.environment == "prod" ? 1 : 0
  bucket        = "maciek-logic-prod-backup-2026"
  force_destroy = true

  tags = {
    Name        = "prod-only-backup"
    Environment = var.environment
  }
}
