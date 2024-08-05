ec2_config = [ {
  ami = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
},
{
    ami = "ami-0ba9883b710b05ac6"
    instance_type = "t3.micro"
} ]

ec2_map = {
  #key=value
  "ubuntu" = {
    ami           = "ami-0705384c0b33c194c" #ubuntu
    instance_type = "t3.micro"
  },
  "amazon-linux" = {
    ami           = "ami-052387465d846f3fc" #amazon linux
    instance_type = "t3.micro"
  }
}