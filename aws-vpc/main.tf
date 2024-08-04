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

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "public-subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "public-subnet"
    }
}

resource "aws_subnet" "private-subnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "private-subnet"
    }
}

resource "aws_route_table" "my-route-table" {
    vpc_id =  aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igw.id
    }
}

resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.my-route-table.id
  subnet_id = aws_subnet.public-subnet.id
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }
}

resource "aws_instance" "MyInstance-03" {
   ami="ami-0583d8c7a9c35822c"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-subnet.id
  tags = {
    Name= "MyInstance-02"
  }
}