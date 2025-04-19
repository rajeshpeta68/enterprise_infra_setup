output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.ent_vpc.id
}

output "ent_public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.ent_public_subnet[*].id  
}

output "ent_private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.ent_private_subnet[*].id  
}

output "aws_security_group_id_ent_ec2_sg" {
  description = "The ID of the security group"
  value       = aws_security_group.ent_ec2_sg.id
}

output "aws_security_group_id_ent_alb_sg" {
  description = "The ID of the security group"
  value       = aws_security_group.ent_alb_sg.id
}

output "aws_security_group_id_ent_rds_sg" {
  description = "The ID of the security group"
  value       = aws_security_group.ent_rds_sg.id
}