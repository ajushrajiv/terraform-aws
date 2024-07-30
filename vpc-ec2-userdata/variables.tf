variable "aws_region" {
  description = "AWS region to deploy"
  default     = "eu-central-1"
}

variable "ami" {
  description = "ami used for ec2 creation"
}

variable "instance_type" {
  description = "type of Ec2 instance"
}