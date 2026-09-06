variable "enable_audit_logs" {
  type    = bool
  default = false
}
variable "network_subnets" {
  type = map(object({
    cidr_block = string
    public_ip  = bool
  }))
  default = {
    "public"  = { cidr_block = "10.0.1.0/24", public_ip = true }
    "private" = { cidr_block = "10.0.2.0/24", public_ip = false }
  }
}
