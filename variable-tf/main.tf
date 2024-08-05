terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "5.61.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "MyInstance-04" {
  ami="ami-0583d8c7a9c35822c"
  instance_type = var.aws_instance_type
  tags = {
    Name= "MyInstance-04"
  }
}