provider "aws" {
  region = var.region
}

variable "region" {
  description = "This is ec2_instance region"
}

variable "instance_type" {
  description = "This is instance type"
}

variable "ami" {
  description = "This is the AMI for the instance"
}

resource "aws_instance" "myec22" {
  ami = var.ami
  instance_type = var.instance_type
}