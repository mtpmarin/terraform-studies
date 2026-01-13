resource "aws_vpc" "vpc_default" {
    cidr_block = var.cidr_block

    tags = { 
        Name = var.name
    }
}