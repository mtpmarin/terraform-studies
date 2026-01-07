variable "s3_bucket_name" {
    type = string
    description = "My first Terraform Bucket"
    default = "terraform-state-bucket"
}

variable "access_key" {
    type = string
    sensitive = true
}

variable "secret_key" {
    type = string
    sensitive = true
}