# VPC
resource "aws_vpc" "vpc_main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

# Public Subnet
resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.vpc_main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-public-subnet"
  }
}

# Private Subnet
resource "aws_subnet" "subnet_private" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone
  tags = {
    Name = "${var.vpc_name}-private-subnet"
  }
}

# Public Route Table
resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc_main.id
  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

# Route for Internet Access in Public Subnet
resource "aws_route" "route_public_internet" {
  route_table_id         = aws_route_table.route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_main.id
}

# Internet Gateway
resource "aws_internet_gateway" "igw_main" {
  vpc_id = aws_vpc.vpc_main.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Private Route Table
resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.vpc_main.id
  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
}

# Security Group
resource "aws_security_group" "sg_main" {
  vpc_id      = aws_vpc.vpc_main.id
  name        = "${var.vpc_name}-sg"
  description = "Allow inbound HTTP and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Route Table Associations
resource "aws_route_table_association" "assoc_public_subnet" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_route_table_association" "assoc_private_subnet" {
  subnet_id      = aws_subnet.subnet_private.id
  route_table_id = aws_route_table.route_table_private.id
}
