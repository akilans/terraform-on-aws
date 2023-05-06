
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.66.1"
    }
  }
  backend "s3" {
    bucket = "aki-terraform-test-bucket"
    region = "ap-south-1"
    key    = "myapp/tf.state"
  }
}

provider "aws" {
  region = var.region
}
