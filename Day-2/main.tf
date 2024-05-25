provider "aws" {
  # Configuration options
  region = "us-east-1"
}

module "ec2_instance" {
    source = "./modules/ec2_instance"
    ami = "ami-04b70fa74e45c3917"
    instance_type = "t2.micro"
    key_name = "aws_login"
    region = "us-east-1"
}