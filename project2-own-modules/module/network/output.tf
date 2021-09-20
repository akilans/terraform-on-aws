output "security_group" {
  value = aws_security_group.allow_ssh_http
}

output "subnet" {
  value = aws_subnet.mysubnet-1
}
