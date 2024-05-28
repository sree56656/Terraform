provider "aws" {
  region = var.region
}

variable "region" {
  description = "This is dev region"
  type = string
  default = "us-east-1"
}

variable "ami" {
  description = "This is ami id"
}

variable "instance_type" {
  description = "This is ec2 instance type"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "prod" = "t2.micro"
    "stage" = "t2.medium"
  }
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
  region = var.region
}