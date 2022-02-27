resource "aws_vpc" "custom-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags                 = var.tags
}

resource "aws_subnet" "custom-public-subnet" {
  vpc_id     = aws_vpc.custom-vpc.id
  cidr_block = var.public_subnet_cidr
  tags       = var.tags
}

resource "aws_internet_gateway" "custom-igw" {
  vpc_id = aws_vpc.custom-vpc.id
  tags   = var.tags
}

resource "aws_route_table" "custom-route-table" {
  vpc_id = aws_vpc.custom-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom-igw.id
  }

  tags = var.tags
}

resource "aws_route_table_association" "custom-route-table-asoc" {
  subnet_id      = aws_subnet.custom-public-subnet.id
  route_table_id = aws_route_table.custom-route-table.id
}