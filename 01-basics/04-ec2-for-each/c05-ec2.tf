data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_instance" "demoec2" {
  ami = data.aws_ami.amzonlinux.id
  #instance_type          = var.instance_type
  #instance_type          = var.list_instance_type[0]
  instance_type          = var.map_instance_type["dev"]
  user_data              = file("${path.module}/install.sh")
  key_name               = var.ec2_key_pair
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_web.id]
  #count                  = 3
  for_each          = toset(data.aws_availability_zones.my_azones.names)
  availability_zone = each.key
  tags = {
    "Name" : "demo-ec2-${each.value}"
  }
}
