resource "aws_instance" "example_instance" {
  ami                         = "ami-01e444924a2233b07" 
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  security_groups             = [ aws_security_group.example_sg.id ]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "example_instance"
  }
}
