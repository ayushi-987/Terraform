terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "5.61.0"
    }
    random={
        source = "hashicorp/random"
        version = "3.6.2"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}
resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "static-project" {
   bucket = "my-ayushi-2-${random_id.rand_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "static-proj" {
  bucket = aws_s3_bucket.static-project.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static-pro" {
  bucket = aws_s3_bucket.static-project.id
  policy = jsonencode(
    {
    Version: "2012-10-17",
    Statement: [
        {
            Sid: "PublicReadGetObject",
            Effect: "Allow",
            Principal: "*",
            Action: "s3:GetObject",
            Resource: "${aws_s3_bucket.static-project.arn}/*"
        }
    ]
}
  )
}

resource "aws_s3_bucket_website_configuration" "static-proj" {
  bucket = aws_s3_bucket.static-project.id

  index_document {
    suffix = "index.html"
  }
}


resource "aws_s3_object" "index-html" {
    bucket = aws_s3_bucket.static-project.bucket
    source = "./index.html"
    key = "index.html"
    content_type = "text/html"
}

resource "aws_s3_object" "hackathon-css" {
    bucket = aws_s3_bucket.static-project.bucket
    source = "./hackathon.css"
    key = "hackathon.css"
    content_type = "text/css"
}

resource "aws_s3_object" "hackathon-html" {
    bucket = aws_s3_bucket.static-project.bucket
    source = "./hackathon.html"
    key = "hackathon.html"
    content_type = "text/html"
}

resource "aws_s3_object" "hackathon-js" {
    bucket = aws_s3_bucket.static-project.bucket
    source = "./hackathon.js"
    key = "hackathon.js"
    content_type = "application/javascript"
}

resource "aws_s3_object" "ran-png" {
    bucket = aws_s3_bucket.static-project.bucket
    source =  "./images/512.png"
    key = "images/512.png"
    content_type = "image/png"
}

resource "aws_s3_object" "cursor-cur" {
    bucket = aws_s3_bucket.static-project.bucket
    source =  "./images/cursor.cur"
    key = "images/cursor.cur"
    content_type = "image/x-icon"
}

resource "aws_s3_object" "help-png" {
    bucket = aws_s3_bucket.static-project.bucket
    source =  "./images/help.png"
    key = "images/help.png"
    content_type = "image/png"
}

output "name" {
  value = aws_s3_bucket_website_configuration.static-proj.website_endpoint
}