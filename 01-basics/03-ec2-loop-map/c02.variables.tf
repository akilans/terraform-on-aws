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

// EC2 instance type as list
variable "list_instance_type" {
  type        = list(string)
  description = "list of EC2 instance type"
  default     = ["t2.micro", "t2.nano", "t2.small"]
}

// EC2 instance type as map
variable "map_instance_type" {
  type        = map(string)
  description = "list of EC2 instance type"
  default = {
    dev  = "t2.nano",
    qa   = "t2.micro",
    prod = "t2.small"
  }
}

