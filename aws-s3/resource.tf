resource "aws_s3_bucket" "mybucket1881" {
  bucket = "my-ayushi-${random_id.rand_id.hex}" # Ensure this bucket name is globally unique
}

resource "aws_s3_object" "bucket-data" {
    bucket = aws_s3_bucket.mybucket1881.bucket
    source = "./myfile.txt"
    key = "mydata.txt"
}

resource "random_id" "rand_id" {
    byte_length = 8
}