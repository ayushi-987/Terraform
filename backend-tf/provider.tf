terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.61.0"
    }
  }
  backend "s3" {
    bucket = "my-ayushi-8dc8649188bec4ec"
    key = "backend.tfstate"
    region = "us-east-1"
  }
}
provider "aws" {
  # Configuration options
  region = var.region
}