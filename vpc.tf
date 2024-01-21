resource "aws_vpc" "LAB_VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "LAB_VPC"
  }
}
resource "aws_subnet" "LAB_public_subnet" {
  vpc_id                  = aws_vpc.LAB_VPC.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "LAB_public_subnet"
  }
}
resource "aws_subnet" "LAB_private_subnet-1" {
  vpc_id                  = aws_vpc.LAB_VPC.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "LAB_private_subnet-1"
  }
}

resource "aws_subnet" "LAB_private_subnet-2" {
  vpc_id                  = aws_vpc.LAB_VPC.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "LAB_private_subnet-2"
  }
}
resource "aws_internet_gateway" "LAB_igw" {
  vpc_id = aws_vpc.LAB_VPC.id

  tags = {
    Name = "LAB_IGW"
  }
}
resource "aws_route_table" "LAB_public-rt" {
  vpc_id = aws_vpc.LAB_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.LAB_igw.id
  }
  tags = {
    Name = "LAB_public-rt"
  }
}
resource "aws_route_table_association" "LAB_public" {
  subnet_id      = aws_subnet.LAB_public_subnet.id
  route_table_id = aws_route_table.LAB_public-rt.id
}

resource "aws_security_group" "LAB_web_SG" {
  name        = "LAB_web_SG"
  description = "LAB_web_SG"
  vpc_id      = aws_vpc.LAB_VPC.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
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
    Name = "LAB_web_SG"
  }
}
