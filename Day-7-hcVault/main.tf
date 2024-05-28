provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = "http://44.220.164.79:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
        role_id = "9f5e3882-03e0-5c97-c59d-457297924d86"
        secret_id = "03c04a2c-537d-748a-fefd-ce9290791348"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv"
  name  = "test-secret"
}

resource "aws_instance" "example" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"

  tags = {
    secret = data.vault_kv_secret_v2.example.data["username"]
  }
}
