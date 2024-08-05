terraform {}

#Number List
variable "num_list" {
  type = list(number)
  default = [ 1,2,3,4,5 ]
}

#Object List of person
variable "person_list" {
  type = list(object({
    name = string
    age = number
    marks = list(number)
  }))
  default = [{
    name="Raju"
    age=15
    marks=[66,83,76,45,58]
  },{
    name="Mahon"
    age=16
    marks=[66,83,76,45,58]
  }]
}

#Liat of Map

variable "map_list" {
  type = map(number)
  default = {
    "zero" = 0
    "one" = 1
    "two" = 2
  }
}

#Calculations

locals {
  mul=20*40
  add=2+89

  double = [for num in var.map_list : num*2]
  name = [for person in var.person_list : person.name]
}

output "above_output" {
  value = local.name
}