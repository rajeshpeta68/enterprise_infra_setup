/*provider "aws" {
  region = var.aws_region[terraform.workspace]
  
}*/

module "networking" {
  source = "./modules/networking" 
}