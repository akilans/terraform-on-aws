output "ec2_puplicIP" {
  description = "EC2 instance IP address"
  value       = aws_instance.demoec2.public_ip
}


output "ec2_puplicDNS" {
  description = "EC2 instance DNS"
  value       = aws_instance.demoec2.public_dns
}
