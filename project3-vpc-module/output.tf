output "ec2_public_ip" {
  value = module.httpd.ec2_info.public_ip
}
