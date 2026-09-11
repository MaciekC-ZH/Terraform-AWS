variable "tables" {
  type = map(object({
    storage_class = string
    encrypted     = bool
  }))
}
variable "env_name" {
  type    = string
  default = "dev"
}
