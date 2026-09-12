# resource "aws_instance" "legacy_server" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t3.micro"

# }

# import {
#   to = aws_instance.legacy_server
#   id = "i-0abcd1234ef567890"

# }

# # terraform import aws_instance.legacy_server i-0abcd1234ef567890

# moved {
#   from = aws_s3_bucket.user_data
#   to = module.storage.aws_s3_bucket.this
# }
variable "db_password" {
  type        = string
  description = "Haslo główne do bazy danych"
  sensitive   = true
}
output "database_connection_string" {
  value     = "Server=db.example.com;Password=${var.db_password}"
  sensitive = true
}
