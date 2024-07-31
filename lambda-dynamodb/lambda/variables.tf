variable "region" {
  description = "The AWS region to deploy in"
  default     = "eu-central-1"
}

variable "filename" {
  description = "Path to the zip file"
  default     = "./todoexpress.zip.zip"
}
