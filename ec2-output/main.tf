provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "example_sg" {
  name        = "example_sg"
  description = "Security group for SSH, HTTP, and HTTPS access"
  vpc_id      = aws_vpc.example_vpc.id

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

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example_subnet" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_instance" "example_instance" {
  ami           = "ami-01e444924a2233b07" 
  instance_type = "t2.nano"
  subnet_id     = aws_subnet.example_subnet.id
  key_name      = "test-key"
  tags = {
    Name = "cheese cake"
  }
  vpc_security_group_ids = [aws_security_group.example_sg.id]
}

resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id
}

resource "aws_route_table" "example_route_table" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_igw.id
  }
}

resource "aws_route_table_association" "example_route_table_assoc" {
  subnet_id      = aws_subnet.example_subnet.id
  route_table_id = aws_route_table.example_route_table.id
}

output "public_ip" {
  value = aws_instance.example_instance.public_ip
}

output "security_group_name" {
  value = aws_security_group.example_sg.name
}

output "security_group_rule_ssh_arn" {
  value = aws_security_group.example_sg.ingress[*]
}

