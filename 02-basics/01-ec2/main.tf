resource "aws_instance" "my-ec2" {
    ami = "ami-07d3a50bd29811cd1"
    key_name = "my-ec2-kp"
    instance_type = "t2.micro"
}