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

resource "aws_instance" "server" {
  ami           = "ami-04ff9e9b51c1f62ca"
  instance_type = "t2.micro"
}

output "public_ip" {
  value = aws_instance.server.public_ip
}