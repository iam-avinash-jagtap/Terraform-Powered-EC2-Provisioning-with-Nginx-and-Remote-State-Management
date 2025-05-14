# Variables which are used into main file
variable "ami" {
  default = "ami-0f88e80871fd81e91"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}
variable "ec2_default_root_block_device" {
  type = number
  default = "10"
}
# This Variabel is for the conditional statement
variable "env" {
    type = string
    default = "production"
  
}