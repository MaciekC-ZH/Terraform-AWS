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
locals {
  nodes_by_env = {
    dev = {
      worker = {
        instance_type = "t3.micro"
        role          = "worker"
      }
    }
    prod = {
      worker = {
        instance_type = "t3.medium"
        role          = "worker"
      }
      api = {
        instance_type = "t3.large"
        role          = "api"
      }
    }
  }
  current_env_config = lookup(local.nodes_by_env, terraform.workspace, local.nodes_by_env["dev"])
}

module "app_cluster" {
  source        = "./modules/compute_cluster"
  cluster_nodes = local.current_env_config
  environment   = terraform.workspace
}
resource "aws_s3_bucket" "backup" {
  count         = terraform.workspace == "prod" ? 1 : 0
  bucket        = "firma-backup-data-prod-2026"
  force_destroy = false
}
