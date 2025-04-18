resource "aws_internet_gateway" "ent_gateway" {
  vpc_id = aws_vpc.ent_vpc.id
  tags = {
    Name = "ent-${terraform.workspace}-internet-gateway"
    Environment = terraform.workspace
  }  
}