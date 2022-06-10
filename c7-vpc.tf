# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

# Resource-1: Create VPC
resource "aws_vpc" "vpc-knab" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "vpc-knab"
  }
}
# Resource-2: Create Subnets
resource "aws_subnet" "vpc-knab-public-subnet-1" {
  vpc_id     = aws_vpc.vpc-knab.id
  cidr_block = "10.0.1.0/24"
  # availability_zone       = "us-east-1a"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "knab-public-subnet-1"
  }
}

resource "aws_subnet" "vpc-knab-private-subnet-1" {
  vpc_id     = aws_vpc.vpc-knab.id
  cidr_block = "10.0.2.0/24"
  # availability_zone       = "us-east-1a"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "knab-private-subnet-1"
  }
}

resource "aws_subnet" "vpc-knab-public-subnet-2" {
  vpc_id     = aws_vpc.vpc-knab.id
  cidr_block = "10.0.3.0/24"
  # availability_zone       = "us-east-1b"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "knab-public-subnet-2"
  }
}

resource "aws_subnet" "vpc-knab-private-subnet-2" {
  vpc_id     = aws_vpc.vpc-knab.id
  cidr_block = "10.0.4.0/24"
  # availability_zone       = "us-east-1b"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "knab-private-subnet-2"
  }
}

# Resource-3: Internet Gateway
resource "aws_internet_gateway" "vpc-knab-igw" {
  vpc_id = aws_vpc.vpc-knab.id
}

# Resource-4: Create Route Table
resource "aws_route_table" "vpc-knab-public-route-table" {
  vpc_id = aws_vpc.vpc-knab.id
}

resource "aws_route_table" "vpc-knab-private-route-table" {
  vpc_id = aws_vpc.vpc-knab.id
}

# Resource-5: Create Route in Route Table for Internet Access
resource "aws_route" "vpc-knab-public-route" {
  route_table_id         = aws_route_table.vpc-knab-public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc-knab-igw.id
}

resource "aws_route" "vpc-knab-private-route" {
  route_table_id         = aws_route_table.vpc-knab-private-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.vpc-knab-nat.id
}

# Resource-6: Associate the Route Table with the Subnet
resource "aws_route_table_association" "vpc-knab-public-route-table-associate-ps1" {
  route_table_id = aws_route_table.vpc-knab-public-route-table.id
  subnet_id      = aws_subnet.vpc-knab-public-subnet-1.id
}

resource "aws_route_table_association" "vpc-knab-public-route-table-associate-ps2" {
  route_table_id = aws_route_table.vpc-knab-public-route-table.id
  subnet_id      = aws_subnet.vpc-knab-public-subnet-2.id
}

resource "aws_route_table_association" "vpc-knab-private-route-table-associate-pr1" {
  route_table_id = aws_route_table.vpc-knab-private-route-table.id
  subnet_id      = aws_subnet.vpc-knab-private-subnet-1.id
}

resource "aws_route_table_association" "vpc-knab-private-route-table-associate-pr2" {
  route_table_id = aws_route_table.vpc-knab-private-route-table.id
  subnet_id      = aws_subnet.vpc-knab-private-subnet-2.id
}

resource "aws_eip" "nat_gateway_knab" {
  vpc = true
}

resource "aws_nat_gateway" "vpc-knab-nat" {
  allocation_id = aws_eip.nat_gateway_knab.id
  subnet_id     = aws_subnet.vpc-knab-public-subnet-1.id
  tags = {
    "Name" = "Nat-Gateway-Knab"
  }
  depends_on = [aws_eip.nat_gateway_knab]
}