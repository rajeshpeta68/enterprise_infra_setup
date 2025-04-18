data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


resource "aws_lb_target_group" "ent_tg" {
  name     = "ent-${terraform.workspace}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 3
    interval            = 30
    timeout             = 5
    path                = "/index.html"
    unhealthy_threshold = 3
  }

  tags = {
    Name        = "ent-${terraform.workspace}-tg"
    Environment = terraform.workspace
  }
}

resource "aws_launch_template" "ent_launch_template" {
  name_prefix   = "ent-${terraform.workspace}-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    device_index                = 0
    subnet_id                  = element(aws_subnet.ent_public_subnet[*].id, count.index)
  }
  tags = {
    Name        = "ent-${terraform.workspace}-launch-template"
    Environment = terraform.workspace
  }
  
}