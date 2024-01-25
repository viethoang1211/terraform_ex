variable "ami-string"{
    type = string
    default = "ami-0fa377108253bf620"
}
variable "aws_instance_type" {
    default = "t2.micro"
}

variable "aws_instance_azs" {
    type = string
    default = "ap-southeast-1a"
}

variable "aws_instance_name" {
    type = string
    default = "Demo_Instance"
}

variable "aws_subnet_id" {
    type = string
}