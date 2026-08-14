variable "aws_region" {
  type    = string
  default = "eu-central-1"
}
variable "instance_type" {
  type    = string
  default = "t3.mini"
}
variable "key_name" {
  type    = string
  default = "klucz-aws-frankfurt"
}
variable "bucket_name" {
  type    = string
  default = "bucket-final-boss"
}
variable "common_tags" {
  type = map(string)
  default = {
    "Owner"       = "Maciek"
    "Project"     = "Final"
    "Environment" = "Dev"
  }

}
