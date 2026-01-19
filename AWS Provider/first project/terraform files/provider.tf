terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# I created an AWS account just to continue with terraform practice
provider "aws" {
  region = "us-east-1"
}