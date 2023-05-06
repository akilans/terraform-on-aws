# get amazon liunx 3 ami id
data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # amazon
}


# Get default vpc id
data "aws_vpc" "default_vpc" {
  default = true
}


# Create sg - allow ssh and http

resource "aws_security_group" "web-app-sg" {
  name        = "web-ssh-sg"
  description = "Allow ssh and http"

  dynamic "ingress" {
    for_each = toset(var.allow_ports)
    content {
      description = "allow ssh"
      to_port     = ingress.value
      from_port   = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp"
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ssh-http-sg"
  }

}


# create ec2 instances with apache server 

resource "aws_instance" "my-server" {

  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  key_name               = "my-ec2-kp"
  count                  = var.number_of_instances
  vpc_security_group_ids = [aws_security_group.web-app-sg.id]
  user_data              = file("httpd.sh")

  tags = merge(var.ec2_tags, {
    Name = "Web server-${count.index + 1}"
  })




}
