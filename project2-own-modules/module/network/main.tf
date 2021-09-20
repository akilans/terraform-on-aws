
resource "aws_subnet" "mysubnet-1" {
  cidr_block        = "10.0.10.0/24"
  vpc_id            = var.vpc_id
  availability_zone = var.availability_zone
  tags = {
    Name = "my-subnet-1"
    env  = "${var.env}-my-subnet-1"
  }
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "my-igw"
    env  = "${var.env}-my-igw"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = var.vpc_id
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
  vpc_id      = var.vpc_id

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
