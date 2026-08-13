variable "aws_region" {
  description = "Region AWS"
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "key_name" {
  type    = string
  default = "klucz-aws-frankfurt"
}
variable "project_tags" {
  type = map(string)
  default = {
    "Owner"       = "Maciek"
    "Environment" = "Dev"
  }

}
