# Import the VPC and subnet IDs from the S3 backend
data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "test-terraform-bucket-techstarter-example-vpc-july30"
    key    = "vpc-example/terraform.tfstate"
    region = var.aws_region
  }
}

resource "aws_security_group" "example_sg" {
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

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
    Name = "example-sg"
  }
}

resource "aws_instance" "example" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = data.terraform_remote_state.network.outputs.public_subnet_id_1a
  security_groups = [aws_security_group.example_sg.id]

  user_data = <<-EOF
    #!/bin/bash
              apt-get update
              apt-get install -y apache2
              echo "<html><body><h1>Hello, World</h1></body></html>" > /var/www/html/index.html
              systemctl enable apache2
              systemctl start apache2
  EOF

  tags = {
    Name = "instance-userdata"
  }
}
