output "instance-public-ip" {
  description = "public IP of the EC2 instance"
  value = aws_instance.My-Nginx.public_ip
}

output "instance_url" {
  description = "The url to access the nginx server"
  value = "http://${aws_instance.My-Nginx.public_ip}"
}