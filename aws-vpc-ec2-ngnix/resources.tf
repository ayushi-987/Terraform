resource "aws_instance" "My-Nginx" {
   ami="ami-0583d8c7a9c35822c"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
        #!/bin/bash
        sudo yum install nginx -y
        sudo systemctl start nginx
        EOF

  tags = {
    Name= "My-Nginx"
  }
}