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

data "aws_ami" "name" {
  most_recent = true
  owners = ["amazon"]
}

output "aws_ami" {
  value = data.aws_ami.name.id
}

data "aws_security_group" "name"{
    tags ={
        Name = "nginx-sg"
    }
}

output "aws_security_group" {
  value = data.aws_security_group.name.id
}

data "aws_vpc" "name"{
  tags = {
    Name = "my_vpc"
  }
}

output "aws_vpc" {
  value = data.aws_vpc.name.id
}

data "aws_subnet" "name"{
  filter {
    name = "vpc-id"
    values = [ data.aws_vpc.name.id ]
  }
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_instance" "My_Instance-03" {
  ami="ami-0583d8c7a9c35822c"
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.name.id
  security_groups = [ data.aws_security_group.name.id ]
  tags = {
    Name= "MyInstance-03"
  }
}
