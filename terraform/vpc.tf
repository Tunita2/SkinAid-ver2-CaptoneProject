data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "skinaid-vpc" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "skinaid-igw" }
}

resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 1)
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-az1" }
}

resource "aws_subnet" "private_app_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 10)
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = { Name = "private-app-subnet-az1" }
}
resource "aws_subnet" "private_db_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 20)
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = { Name = "private-db-subnet-az1" }
}

resource "aws_subnet" "private_app_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 11)
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = { Name = "private-app-subnet-az2" }
}
resource "aws_subnet" "private_db_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 21)
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = { Name = "private-db-subnet-az2" }
}

resource "aws_eip" "nat_az1" {
  domain = "vpc"
}
resource "aws_nat_gateway" "nat_gw_az1" {
  allocation_id = aws_eip.nat_az1.id
  subnet_id     = aws_subnet.public_az1.id
  depends_on    = [aws_internet_gateway.igw]
  tags = { Name = "skinaid-nat-az1" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "public-rt" }
}
resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_az1.id
  }
  tags = { Name = "private-rt" }
}
resource "aws_route_table_association" "private_app_az1" {
  subnet_id      = aws_subnet.private_app_az1.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_app_az2" {
  subnet_id      = aws_subnet.private_app_az2.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_db_az1" {
  subnet_id      = aws_subnet.private_db_az1.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_db_az2" {
  subnet_id      = aws_subnet.private_db_az2.id
  route_table_id = aws_route_table.private.id
}
