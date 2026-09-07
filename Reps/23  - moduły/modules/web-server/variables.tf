variable "bucket_name" {
  type = string
}
variable "enable_versioning" {
  type    = bool
  default = false
}
variable "env_tag" {
  type    = string
  default = "dev"
}
