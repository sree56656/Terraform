# Below code is to get the existing S3 bucket
terraform {
  backend "s3" {
    bucket = "sree-tf-bucket"
    key    = "Sree/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_table = "terraform_lock"
  }
}