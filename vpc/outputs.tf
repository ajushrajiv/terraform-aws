output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_a_id" {
  description = "The ID of the private subnet in AZ a"
  value       = aws_subnet.private_a.id
}

output "private_subnet_b_id" {
  description = "The ID of the private subnet in AZ b"
  value       = aws_subnet.private_b.id
}

output "public_subnet_a_id" {
  description = "The ID of the public subnet in AZ a"
  value       = aws_subnet.public_a.id
}

output "public_subnet_b_id" {
  description = "The ID of the public subnet in AZ b"
  value       = aws_subnet.public_b.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}
