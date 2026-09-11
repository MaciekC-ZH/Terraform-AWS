variable "vpc_id" {
  type = string
}
variable "subnets_config" {
  type = map(object({
    cidr_block = string
    is_public  = bool
  }))
}
variable "env_name" {
  type = string
}
