terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "web-app/terraform.state"
    region = "us-east-1"
  }
}