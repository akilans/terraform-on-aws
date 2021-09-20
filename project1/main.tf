terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.56.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "aws_zones" {
  state = "available"
}

data "aws_ami" "my_ami" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
    env  = "${var.env}-my-vpc"
  }
}

resource "aws_subnet" "mysubnet-1" {
  cidr_block        = "10.0.10.0/24"
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = data.aws_availability_zones.aws_zones.names[0]
  tags = {
    Name = "my-subnet-1"
    env  = "${var.env}-my-subnet-1"
  }
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "my-igw"
    env  = "${var.env}-my-igw"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "my-rt"
    env  = "${var.env}-my-rt"
  }
}

resource "aws_route_table_association" "my_route_table_association" {
  route_table_id = aws_route_table.my_route_table.id
  subnet_id      = aws_subnet.mysubnet-1.id
}


resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH/HTTP inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {
    Name = "allow_ssh_http_sg"
  }
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my_key_pair"
  public_key = file("/home/akilan/.ssh/id_rsa.pub")
}

resource "aws_instance" "my_ec2" {
  ami                         = data.aws_ami.my_ami.id
  availability_zone           = data.aws_availability_zones.aws_zones.names[0]
  key_name                    = aws_key_pair.my_key_pair.key_name
  instance_type               = var.ec2_instance_type
  user_data                   = file("httpd.sh")
  vpc_security_group_ids      = [aws_security_group.allow_ssh_http.id]
  subnet_id                   = aws_subnet.mysubnet-1.id
  associate_public_ip_address = true

  connection {
    type        = "ssh"
    private_key = file("/home/akilan/.ssh/id_rsa")
    host        = self.public_ip
    user        = "ec2-user"
  }

  provisioner "file" {
    source      = "test.sh"
    destination = "/home/ec2-user/test.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/test.sh",
      "/home/ec2-user/test.sh",
    ]
  }

  provisioner "local-exec" {
    command = "curl ${aws_instance.my_ec2.public_ip}"
  }

  tags = {
    Name = "my-ec2"
  }

}



output "my_ami_id" {
  value = data.aws_ami.my_ami.id
}

output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}
