# create vpc
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name = "${var.customer}-${var.project}-vpc-${var.environment}"
  }
}

# Public subnet for the ALB
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.pub_sub_cidr
  availability_zone = var.public_az
  #   map_public_ip_on_launch = true
  tags = {
    Name = "${var.customer}-${var.project}-pub-sub-${var.environment}"
  }
}

# Private subnet for our Fargate tasks
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.pri_sub_cidr
  availability_zone = var.private_az
  tags = {
    Name = "${var.customer}-${var.project}-pri-sub-${var.environment}"
  }
}

# Internet Gateway for public subnet 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.customer}-${var.project}-igw-${var.environment}"
  }
}

# Route table for public subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.customer}-${var.project}-public_rt-${var.environment}"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# NAT Gateway for private subnet
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "${var.customer}-${var.project}-nat-eip-${var.environment}"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "${var.customer}-${var.project}-nat-gw-${var.environment}"
  }
}

# Route table for private subnet
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.customer}-${var.project}-private_rt-${var.environment}"
  }
}

resource "aws_route_table_association" "private_rt_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}
