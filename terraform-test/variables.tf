variable "number_of_instances" {
  type        = number
  description = "Number of ec2 instances"
  default     = 2
}


variable "region" {
  type        = string
  description = "Region to spin up ec2"
  default     = "ap-south-1"
}


variable "instance_type" {
  type        = string
  description = "Instance type"
  default     = "t2.micro"
}


# Allow ports
variable "allow_ports" {
  type    = list(any)
  default = [22, 80]
  description = "Open access ports for all"
}

# ec2 tags
variable "ec2_tags"{
  type = map
  default = {
    "env" = "dev"
    "app" = "frontend"
  }
}