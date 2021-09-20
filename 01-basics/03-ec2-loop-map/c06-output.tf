output "legacy1_ec2_puplicIP" {
  description = "legacy1 EC2 instance IP address"
  value       = aws_instance.demoec2.*.public_ip
}

output "legacy2_ec2_puplicIP" {
  description = "legacy2 EC2 instance IP address"
  value       = aws_instance.demoec2[*].public_ip
}

output "list_ec2_puplicIP" {
  description = "List EC2 instance IP address"
  value       = [for instance in aws_instance.demoec2 : instance.public_ip]
}

output "map_ec2_puplicIP" {
  description = "map EC2 instance IP address"
  value       = { for instance in aws_instance.demoec2 : instance.id => instance.public_ip }
}


output "legacy1_ec2_puplicDNS" {
  description = "EC2 instance DNS"
  value       = aws_instance.demoec2.*.public_dns
}

output "legacy2_ec2_puplicDNS" {
  description = "EC2 instance DNS"
  value       = aws_instance.demoec2[*].public_dns
}

output "list_ec2_puplicDNS" {
  description = "List EC2 instance DNS"
  value       = [for instance in aws_instance.demoec2 : instance.public_dns]
}


output "map_ec2_puplicDNS" {
  description = "Map EC2 instance DNS"
  value       = { for instance in aws_instance.demoec2 : instance.id => instance.public_dns }
}
