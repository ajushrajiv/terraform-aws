output "instance_id" {
  description = "the ID of the instance"
  value = aws_instance.example_instance.id
}

output "public_ip" {
  description = "public IP of the EC2 instance"
  value = aws_instance.example_instance.public_ip
}