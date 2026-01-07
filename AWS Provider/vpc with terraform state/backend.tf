terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key = "vpc/terraform.state"
    region = "us-east-1"
  }
}
