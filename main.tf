/*provider "aws" {
  region = var.aws_region[terraform.workspace]
  
}*/

module "networking" {
  source = "./modules/networking" 
}

module "compute" {
  source = "./modules/compute"
  vpc_id = module.networking.vpc_id 
}