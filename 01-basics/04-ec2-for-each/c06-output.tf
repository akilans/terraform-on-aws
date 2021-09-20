output "list_ec2_puplicIP" {
  description = "List EC2 instance IP address"
  value       = [for instance in aws_instance.demoec2 : instance.public_ip]
}

output "map_ec2_puplicIP" {
  description = "map EC2 instance IP address"
  value       = { for instance in aws_instance.demoec2 : instance.id => instance.public_ip }
}


output "list_ec2_puplicDNS" {
  description = "List EC2 instance DNS"
  value       = [for instance in aws_instance.demoec2 : instance.public_dns]
}


output "map_ec2_puplicDNS" {
  description = "Map EC2 instance DNS"
  value       = { for instance in aws_instance.demoec2 : instance.id => instance.public_dns }
}
