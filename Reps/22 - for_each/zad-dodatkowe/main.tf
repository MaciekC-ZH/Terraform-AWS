terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}
resource "aws_subnet" "managed_subnets" {
  for_each                = var.network_subnets
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = each.value.public_ip
  tags = {
    Name = "subnet-${each.key}"
  }
}
resource "aws_s3_bucket" "security_audit_bucket" {
  count         = var.enable_audit_logs ? 1 : 0
  bucket        = "audit-network-logs-2026"
  force_destroy = true

}
