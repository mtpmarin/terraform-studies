resource "aws_subnet" "frontend" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.frontend_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_name_front
  }
}

resource "aws_subnet" "backend" {
  vpc_id     = var.vpc_id
  cidr_block = var.backend_cidr

  tags = {
    Name = var.subnet_name_back
  }
}
