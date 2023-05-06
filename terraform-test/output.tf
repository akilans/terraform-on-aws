output "Application-URL" {
  value       = aws_instance.my-server.*.public_ip
  description = "Access web application by these URLs"
}
