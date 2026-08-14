output "ec2_public_ip" {
  value = aws_instance.final-ec.public_ip
}
output "ec2_instance_id" {
  value = aws_instance.final-ec.id
}
output "security_group_id" {
  value = aws_security_group.final-sg.id
}
output "s3_bucket_name" {
  value = aws_s3_bucket.final-koszyk.id
}
output "s3_bucket_arn" {
  value = aws_s3_bucket.final-koszyk.arn
}
