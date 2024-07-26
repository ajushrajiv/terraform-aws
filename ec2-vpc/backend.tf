terraform {
  backend "s3" {
    bucket = "test-terraform-bucket-techstarter-example"
    key    ="ec2-example/terraform.tfstate"
    region = "eu-central-1"
  }
}