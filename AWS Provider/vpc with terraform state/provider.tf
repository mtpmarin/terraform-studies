terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
}
}

provider "aws" {
      region = "us-east-1"
      access_key = var.access_key
      secret_key = var.secret_key

      # Necessary configurations to work with LocalStack
      skip_credentials_validation = true
      skip_requesting_account_id  = true
      skip_metadata_api_check     = true
      s3_use_path_style           = true # Required for S3 in LocalStack

      endpoints {
        s3 = "http://localhost.localstack.cloud:4566"
      }

}