resource "aws_dynamodb_table" "ent_dynamodb" {
  name         = "ent-${terraform.workspace}-dynamodb"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "ent-${terraform.workspace}-dynamodb"
    Environment = terraform.workspace
  }
  
}