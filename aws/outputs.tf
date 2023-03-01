output "dev" {
  value = aws_instance.dev.public_ip
}

output "hml" {
  value = aws_instance.hml.public_ip
}
