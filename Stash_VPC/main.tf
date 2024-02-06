locals {
  name   = "toyota-demo"
  region = "us-west-2"
}


resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/20"
  instance_tenancy = "default"

  tags = {
    Name = "${local.name}-vpc"
    resource = "toyota-demo"
  }
}

resource "aws_subnet" "public-sn" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "${local.name}-public-sn"
    resource = "toyota-demo"
  }
}

resource "aws_subnet" "private-sn" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "${local.name}-private-sn"
    resource = "toyota-demo"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.name}-gw"
    resource = "toyota-demo"
  }
}

resource "aws_eip" "eip_nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public-sn.id

  tags = {
    Name = "${local.name}-NAT-GW"
    resource = "toyota-demo"
  }

}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "${local.name}-private-rt"
    resource = "toyota-demo"
  }

  depends_on = [ aws_nat_gateway.nat_gateway ]
}

resource "aws_route_table_association" "private-sn-association" {
  subnet_id      = aws_subnet.private-sn.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${local.name}-public-rt"
    resource = "toyota-demo"
  }
}

resource "aws_route_table_association" "public-sn-association" {
  subnet_id      = aws_subnet.public-sn.id
  route_table_id = aws_route_table.public-rt.id
}

===========================================================================

resource "aws_subnet" "private-sn" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "${local.name}-private-sn"
    resource = "toyota-demo"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public-sn.id

  tags = {
    Name = "${local.name}-NAT-GW"
    resource = "toyota-demo"
  }

}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "${local.name}-private-rt"
    resource = "toyota-demo"
  }

  depends_on = [ aws_nat_gateway.nat_gateway ]
}

resource "aws_route_table_association" "private-sn-association" {
  subnet_id      = aws_subnet.private-sn.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_eip" "eip_nat" {
  vpc = true
}
