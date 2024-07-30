terraform {
  backend "s3" {
    bucket = "test-terraform-bucket-techstarter-example-vpc-july30"
    key    = "vpc-example/terraform.tfstate"
    region = "eu-central-1"
  }
}
