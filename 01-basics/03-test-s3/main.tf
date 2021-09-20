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
  profile = "default"
  region  = "us-east-1"
}

resource "aws_s3_bucket_object" "object" {
  bucket = "akilan-tf-s3"
  key    = "index.html"
  source = "files/index.html"
  etag   = filemd5("files/index.html")
}
