provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "web" {
  ami           = "ami-091f21ecba031b39a"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.ssh.key_name
  tags = {
    Name = "HelloInstance"
  }
}

resource "random_id" "id" {
  byte_length = 4
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "aws_key_pair" "ssh" {
  key_name   = "${random_id.id.hex}-ssh"
  public_key = tls_private_key.ssh.public_key_openssh
  tags       = {}
}