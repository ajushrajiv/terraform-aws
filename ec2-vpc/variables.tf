variable "aws_region" {
  description = "AWS region to deploy"
  default = "eu_central_1"
}

variable "vpc_id" {
    description = "vpc_id"
}

variable "subnet_id" {
    description = "subnet_id"
}

variable "instance_type" {
    description = "instance_type"
    default = "t2.nano"
}

variable "key_name" {
    description = "key_name"
}