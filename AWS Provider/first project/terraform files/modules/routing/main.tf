resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = var.frontend_subnet_id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "alb" {
  name   = "inbound_traffic"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds" {
  name   = "rds-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "ec2" {
  name   = "ec2-sg"
  vpc_id = var.vpc_id
}