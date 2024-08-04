resource "aws_instance" "My_Instance-01" {
  ami="ami-0583d8c7a9c35822c"
  instance_type = "t2.micro"
  tags = {
    Name= "MyInstance-02"
  }
}