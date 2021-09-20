terraform {
  required_version = "~> 1.0"
  backend "s3" {
    bucket = "akilan-tf-s3"
    key    = "myapp/app.tfstate"
    region = "us-east-1"
  }
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

module "network" {
  source            = "./module/network"
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = data.aws_availability_zones.aws_zones.names[0]
  env               = var.env
}


module "httpd" {
  source             = "./module/ec2-httpd"
  ami_id             = data.aws_ami.my_ami.id
  security_group_ids = [module.network.security_group.id]
  user_data_file     = file("httpd.sh")
  availability_zone  = data.aws_availability_zones.aws_zones.names[0]
  ec2_instance_type  = var.ec2_instance_type
  subnet_id          = module.network.subnet.id
}
