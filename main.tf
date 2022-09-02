terraform {
  backend "s3" {
  bucket = "terraform-test-s3-s3-backend"
  dynamodb_table = "terraform-test-s3-s3-backend"
  region = "ap-southeast-1"
  encrypt = true
  key = "terraform-jenkins"
  role_arn = "arn:aws:iam::075119686808:role/Terraform-Test-S3S3BackendRole"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["khoi"]
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Server"
  }
}

output "public_ip" {
  value = aws_instance.server.public_ip
}