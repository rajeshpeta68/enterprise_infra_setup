variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = map(string)
  default = {
    default = "t2.micro"
    dev     = "t3.medium"
    prod    = "t2.micro"
    stage   = "t2.micro"
  }
}

variable "ent_public_subnet_ids" {
  description = "The IDs of the public subnets"
  type        = list(string)
  default     = ["aws_subnet.ent_public_subnet[*].id"]
  
}

variable "aws_security_group_id_ent_ec2_sg" {
  description = "The ID of the security group"
  type        = string 
  #default     = "aws_security_group.ent_ec2_sg.id" 
}

variable "aws_security_group_id_ent_alb_sg" {
  description = "The ID of the security group"
  type        = string
  #default     = "aws_security_group.ent_alb_sg.id"
  
}