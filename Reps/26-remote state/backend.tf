terraform {
  backend "s3" {
    bucket         = "moj-unikalny-bucket-tfstate-2026"
    key            = "prod/app/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
