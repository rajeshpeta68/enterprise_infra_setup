resource "aws_eip" "ent_nat_eip" {
    depends_on = [ aws_internet_gateway.ent_gateway ]
    tags = {
    Name = "ent-${terraform.workspace}-nat-eip"
    Environment = terraform.workspace
  }  
}

resource "aws_nat_gateway" "ent_nat_gateway" {
  #count = length(var.private_subnet_cidrs)
  allocation_id = aws_eip.ent_nat_eip.id
  subnet_id = aws_subnet.ent_public_subnet[0].id
  tags = {
    Name = "ent-${terraform.workspace}-nat-gateway"
    Environment = terraform.workspace
  }
  
}
