terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.61.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

locals {
  project = "project-01"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count = 2
  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}

resource "aws_instance" "instance_main" {
  ami = var.ec2_config[count.index].ami
  instance_type = var.ec2_config[count.index].instance_type
  count = length(var.ec2_config)
  subnet_id = element(aws_subnet.main[*].id, count.index % length(aws_subnet.main))
  tags = {
    name = "${local.project}-instance-${count.index}"
  }
}

resource "aws_instance" "main" {
  for_each = var.ec2_map
  # We will get each.key and each.value

  ami           = each.value.ami
  instance_type = each.value.instance_type

  subnet_id = element(aws_subnet.main[*].id, index(keys(var.ec2_map), each.key) % length(aws_subnet.main))

  tags = {
    Name = "${local.project}-instance-${each.key}"
  }
}