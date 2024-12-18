terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
  # hardcoding credentials 
  access_key = ""                    
  
  secret_key = ""                                        
  
  
}

resource "aws_ssm_parameter" "kyotocomic" {
  name  = "kyotocomic"
  type  = "String"
  value = "barr"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "kyotocomics3bucket123"

  tags = {
    Name = "My bucket"
  }
}

resource "tls_private_key" "rsa_4096_kc" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

variable "key_name" {}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096_kc.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096_kc.private_key_pem
  filename = var.key_name
}

resource "aws_instance" "public_instance" {
  ami           = "ami-0014ce3e52359afbd"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.key_pair.key_name

  tags = {
    Name = "public_instance"
  }
}
