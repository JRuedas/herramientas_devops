terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

data "aws_ami" "jruedas-ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["hello-node-jonatan"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "hello_jruedas_node" {
  ami                         = data.aws_ami.jruedas-ami.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true

  subnet_id              = aws_subnet.jruedas-public-subnet.id
  vpc_security_group_ids = [aws_security_group.jruedas-allow_ssh_http.id]

  tags = {
    Name = "JRuedas-EC2-Instance"
  }
}

resource "aws_vpc" "jruedas-vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "JRuedas-VPC"
  }
}

resource "aws_subnet" "jruedas-public-subnet" {
  vpc_id     = aws_vpc.jruedas-vpc.id
  cidr_block = "192.168.1.0/24"

  tags = {
    Name = "JRuedas-Public-Subnet"
  }
}

resource "aws_internet_gateway" "jruedas-igw" {
  vpc_id = aws_vpc.jruedas-vpc.id

  tags = {
    Name = "JRuedas-Internet-GW"
  }
}

resource "aws_route_table" "jruedas-route-table" {
  vpc_id = aws_vpc.jruedas-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jruedas-igw.id
  }

  tags = {
    Name = "JRuedas-Route-Table"
  }
}

resource "aws_route_table_association" "jruedas-route-table-asoc" {
  subnet_id      = aws_subnet.jruedas-public-subnet.id
  route_table_id = aws_route_table.jruedas-route-table.id
}

resource "aws_security_group" "jruedas-allow_ssh_http" {
  name        = "jruedas-allow_ssh_http"
  description = "Allow SSH and HTTP inbound connections"
  vpc_id      = aws_vpc.jruedas-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "JRuedas-Security-Group"
  }
}