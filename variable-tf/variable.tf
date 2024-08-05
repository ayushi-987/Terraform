variable "aws_instance_type" {
  description = "The type of instance you want to create?"
  type = string
  validation {
    condition = var.aws_instance_type=="t2.micro" || var.aws_instance_type=="t3.micro"
    error_message = "Only t2 & t3 micro is allowed"
  }
}