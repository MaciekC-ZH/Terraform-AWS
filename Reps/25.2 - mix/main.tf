terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
locals {
  tables_by_env = {
    dev = {
      users = {
        storage_class = "STANDARD"
        encrypted     = false
      }
      prod = {
        users = {
          storage_class = "STANDARD_IA"
          encrypted     = true
        }
        orders = {
          storage_class = "GLACIER"
          encrypted     = true
        }
      }
    }
  }
  current_config = lookup(local.tables_by_env, terraform.workspace, local.tables_by_env["dev"])
}

module "database" {
  source   = "./modules/storage_database"
  tables   = local.current_config
  env_name = terraform.workspace
}
resource "aws_s3_bucket" "audit_logs" {
  count         = terraform.workspace == "prod" ? 1 : 0
  bucket        = "audit-db-logs-prod-2026"
  force_destroy = false
}
