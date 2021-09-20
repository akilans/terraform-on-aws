resource "aws_key_pair" "my_key_pair" {
  key_name   = "my_key_pair"
  public_key = file("/home/akilan/.ssh/id_rsa.pub")
}

resource "aws_instance" "my_ec2" {
  ami                         = var.ami_id
  availability_zone           = var.availability_zone
  key_name                    = aws_key_pair.my_key_pair.key_name
  instance_type               = var.ec2_instance_type
  user_data                   = var.user_data_file
  vpc_security_group_ids      = var.security_group_ids
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "my-ec2"
  }

}
