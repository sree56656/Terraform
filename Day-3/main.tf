provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "Sree" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "sree-tf-bucket"

  tags = {
    Name        = "Sree bucket"
    Environment = "Dev"
  }
}

/*resource "aws_dynamodb_table" "terraform_lock" {
    name           = "terraform-lock"
    hash_key         = "LockId"
    billing_mode     = "PAY_PER_REQUEST"

    attribute {
        name = "LockId"
        type = "S"
    }
}
*/