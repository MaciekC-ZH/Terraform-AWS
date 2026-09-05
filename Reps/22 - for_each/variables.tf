variable "app_storage" {
  type = map(object({
    retention_days = number
    force_destroy  = bool
  }))
  default = {
    "logs"   = { retention_days = 90, force_destroy = false }
    "assets" = { retention_days = 365, force_destroy = true }
  }
}
