resource "aws_security_group" "ent_ec2_sg" {
    name        = "ent-${terraform.workspace}-ec2-sg"
    description = "Security group for EC2 instances"
    vpc_id      = aws_vpc.ent_vpc.id
    
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH access"
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP access"
    }
    egress  {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }
  
}

resource "aws_security_group" "ent_alb_sg" {
    name        = "ent-${terraform.workspace}-alb-sg"
    description = "Security group for ALB"
    vpc_id      = aws_vpc.ent_vpc.id
    
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP access"
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"  
}
}

resource "aws_security_group" "ent_rds_sg" {
    name        = "ent-${terraform.workspace}-rds-sg"
    description = "Security group for RDS"
    vpc_id      = aws_vpc.ent_vpc.id
    
    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        security_groups = ["aws_security_group.ent_ec2_sg.id"]
        description = "Allow MySQL access from EC2 security group"
    }
    ingress {
        description = "Allow ssh access from public ec2 host"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        security_groups =  ["aws_security_group.ent_ec2_sg.id"]
    }
    ingress {
        description = "Allow http from public ec2 host"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        security_groups = ["aws_security_group.ent_ec2_sg.id"]
    }
  
}