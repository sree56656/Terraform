variable "instance_type" {
    description = "EC2 instance type"
    type = string  
}

variable "region" {
    description = "AWS region"
    type = string
}

variable "ami" {
    description = "AMI ID"
    type = string
}

variable "key_name" {
    description = "Add key_value pair"
    type = string
}