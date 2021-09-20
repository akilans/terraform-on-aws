// EC2 instance type
variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

// AWS region
variable "aws_region" {
  type        = string
  description = "AWS region to assign resources"
  default     = "us-east-1"
}

// Key pair
variable "ec2_key_pair" {
  description = "Key pair to ssh to EC2"
  default     = "aws-admin"
  type        = string

}
