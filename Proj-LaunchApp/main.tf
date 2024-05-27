provider "aws" {
  region = "us-east-1"
}

variable "cidr" {
  default = "10.0.0.0/16"
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

resource "aws_key_pair" "mykey_pair" {
  key_name   = "ec2_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_subnet" "mysubnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_route_table" "myrta" {
  vpc_id     = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.myrta.id
}

resource "aws_security_group" "mysg" {
    name = "web"
    vpc_id = aws_vpc.myvpc.id
    ingress {
        description = "HTTP from VPC"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
    
    ingress {
        description = "SSH from VPC"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
    Name = "Web-sg"
  }
}

resource "aws_instance" "myec2" {
  ami                     = "ami-04b70fa74e45c3917"
  instance_type           = "t2.micro"
  key_name                = aws_key_pair.mykey_pair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id               = aws_subnet.mysubnet.id

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }
  
  provisioner "file" {
    source      = "app.py"
    destination = "/home/ubuntu/app.py"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip",  # Example package installation
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "sudo python3 app.py &",
    ]
  }
}
    