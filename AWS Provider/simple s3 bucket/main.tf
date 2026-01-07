resource "aws_s3_bucket" "s3bucket" {
    bucket = var.s3_bucket_name

    tags = {
        Name = "Bucket Head"
        Environment = "DEV"
    }
}   