resource "aws_db_subnet_group" "ent_rds_subnet_group" {
  name       = "ent-${terraform.workspace}-rds-subnet-group"
  subnet_ids = var.ent_private_subnet_ids

  tags = {
    Name        = "ent-${terraform.workspace}-rds-subnet-group"
    Environment = terraform.workspace
  }
  
}
resource "aws_db_instance" "ent_rds" {
  identifier              = "ent-${terraform.workspace}-rds"
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  allocated_storage       = var.rds_allocated_storage
  storage_type           = var.rds_storage_type
  db_subnet_group_name    = aws_db_subnet_group.ent_rds_subnet_group.name
  vpc_security_group_ids  = [var.aws_security_group_id_ent_rds_sg]
  multi_az               = false
  publicly_accessible     = false
  username              = var.rds_username
  password              = var.rds_password
  skip_final_snapshot    = true

  tags = {
    Name        = "ent-${terraform.workspace}-rds"
    Environment = terraform.workspace
  }
}