provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami                     = "ami-04b70fa74e45c3917"
  instance_type           = "t2.micro"
  subnet_id               = "subnet-059eced196aa50289"
  key_name = "aws_login"
}