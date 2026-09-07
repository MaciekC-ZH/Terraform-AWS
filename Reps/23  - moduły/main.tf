module "dev_storage" {
  source      = "./modules/web-server"
  bucket_name = "firma-dev-data-2026"

}
module "prod_storage" {
  source            = "./modules/web-server"
  bucket_name       = "firma-prod-archive-2026"
  enable_versioning = true
  env_tag           = "prod"
}
