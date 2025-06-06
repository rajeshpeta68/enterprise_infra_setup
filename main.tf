/*provider "aws" {
  region = var.aws_region[terraform.workspace]
  
}*/

module "networking" {
  source = "./modules/networking" 
}

module "compute" {
  source = "./modules/compute"
  vpc_id = module.networking.vpc_id
  ent_public_subnet_ids = module.networking.ent_public_subnet_ids
  #instance_type = var.instance_type[terraform.workspace]
  aws_security_group_id_ent_ec2_sg = module.networking.aws_security_group_id_ent_ec2_sg
  aws_security_group_id_ent_alb_sg = module.networking.aws_security_group_id_ent_alb_sg
}

module "database" {
  source = "./modules/database"
  ent_private_subnet_ids = module.networking.ent_private_subnet_ids
  aws_security_group_id_ent_rds_sg = module.networking.aws_security_group_id_ent_rds_sg
  rds_password = var.rds_password
  rds_username = var.rds_username
}