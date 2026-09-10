variable "cluster_nodes" {
  type = map(object({
    instance_type = string
    role          = string
  }))
}
variable "environment" {
  type    = string
  default = "dev"
}
