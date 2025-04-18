data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_subnet" "ent_public_subnet" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.ent_vpc.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "ent-${terraform.workspace}-public-subnet-${count.index}"
    Environment = terraform.workspace
    Type = "Public"
  }  
}
/*
resource "aws_subnet" "ent_public_subnet2" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.ent_vpc.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "ent-${terraform.workspace}-private-subnet-${count.index}"
    Environment = terraform.workspace
    Type = "Private"
  }  
} */

resource "aws_subnet" "ent_private_subnet" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.ent_vpc.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "ent-${terraform.workspace}-private-subnet-${count.index}"
    Environment = terraform.workspace
    Type = "Private"
  }
}
/*
resource "aws_subnet" "ent_private_subnet2" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.ent_vpc.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "ent-${terraform.workspace}-private-subnet-${count.index}"
    Environment = terraform.workspace
    Type = "Private"
  }  
}*/

resource "aws_route_table" "ent_public_route_table" {
  vpc_id = aws_vpc.ent_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ent_gateway.id
    }
  tags = {
    Name = "ent-${terraform.workspace}-public-route-table"
    Environment = terraform.workspace
  }
  
}

resource "aws_route_table_association" "ent_public_subnet_association" {
  count =   length(var.public_subnet_cidrs)
  subnet_id = aws_subnet.ent_public_subnet[count.index].id
  route_table_id = aws_route_table.ent_public_route_table.id
}
/*
resource "aws_route_table_association" "ent_public_subnet_association2" {
    count = length(var.private_subnet_cidrs)
    subnet_id = aws_subnet.ent_public_subnet2[count.index].id
    route_table_id = aws_route_table.ent_public_route_table.id
}*/

resource "aws_route_table" "ent_private_route_table" {
  #count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.ent_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.ent_nat_gateway.id
    }
    tags = {
      Name = "ent-${terraform.workspace}-private-route-table"
      Environment = terraform.workspace
    }

}

resource "aws_route_table_association" "ent_private_subnet_association" {
  count = length(var.private_subnet_cidrs)
  subnet_id = aws_subnet.ent_private_subnet[count.index].id
  route_table_id = aws_route_table.ent_private_route_table.id
}