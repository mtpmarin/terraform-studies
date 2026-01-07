resource "aws_vpc" "vpc_default" {
    cidr_block = "10.0.0.0/16"

    tags = { 
        Name = "My First VPC"
    }
}

resource "aws_subnet" "frontend" {
    vpc_id = aws_vpc.vpc_default.id
    cidr_block = "10.0.1.0/30"

    tags = {
        Name = "Frontend Subnet"
    }
}

resource "aws_subnet" "backend" {
    vpc_id = aws_vpc.vpc_default.id
    cidr_block = "10.0.2.0/30"
    
    tags = {
        Name = "Backend Subnet"
    }
}

resource "aws_internet_gateway" "internet_access" {
    vpc_id = aws_vpc.vpc_default.id
}


resource "aws_route_table" "route_rules" {
    vpc_id = aws_vpc.vpc_default.id

    route { 
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_access.id
    }
}

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.frontend.id
    route_table_id = aws_route_table.route_rules.id
}