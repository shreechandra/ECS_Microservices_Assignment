resource "aws_vpc" "createVPC" {
  cidr_block       = "145.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames    = true

  tags = {
    Name = "terraformvpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.createVPC.id
  tags = {
    "Name" = "igw"
  }
}

resource "aws_route_table" "routeigm" {
  vpc_id = aws_vpc.createVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_subnet" "pub-a" {
  vpc_id = aws_vpc.createVPC.id
  cidr_block = "145.0.1.0/24"
  availability_zone = "us-east-2a"
  tags = {
    "Name" = "public -a1"
  }
}

resource "aws_subnet" "pub-b" {
  vpc_id = aws_vpc.createVPC.id
  cidr_block = "145.0.2.0/24"
  availability_zone = "us-east-2c"
  tags = {
    "Name" = "public -b1"
  }
}

resource "aws_route_table_association" "table-a" {
  subnet_id      = aws_subnet.pub-a.id
  route_table_id = aws_route_table.routeigm.id
}

resource "aws_route_table_association" "table-b" {
  subnet_id      = aws_subnet.pub-b.id
  route_table_id = aws_route_table.routeigm.id
}