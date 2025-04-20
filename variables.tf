variable "aws_region" {
type = map(string)
default = {
  default = "ap-south-1"
  dev = "ap-southease-1"
  stage = "us-east-1"
  prod = "us-west-1"
}
}

variable "rds_username" {
  type        = string
  description = "RDS DB username"
}

variable "rds_password" {
  type        = string
  description = "RDS DB password"
  sensitive   = true
}