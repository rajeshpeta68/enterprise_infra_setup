variable "ent_private_subnet_ids" {
  description = "The IDs of the private subnets"
  type        = list(string)  
}

variable "rds_engine" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"  
}

variable "rds_engine_version" {
  description = "The database engine version to use"
  type        = string
  default     = "8.0"  
  
}
variable "rds_instance_class" {
  description = "The instance class to use for the database"
  type        = string
  default     = "db.t3.micro"  
}
variable "rds_allocated_storage" {
  description = "The allocated storage size in GB"
  type        = number
  default     = 20  
}
variable "rds_storage_type" {
  description = "The storage type to use for the database"
  type        = string
  default     = "gp2"  
}
variable "rds_username" {
  description = "The username for the database"
  type        = string
  default     = "admin"  
}
variable "rds_password" {
  description = "The password for the database"
  type        = string
  default     = "password"  
}
variable "aws_security_group_id_ent_rds_sg" {
  description = "The ID of the security group for the RDS instance"
  type        = string
}