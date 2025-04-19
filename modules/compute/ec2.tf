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
  image_id      = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type[terraform.workspace]
  vpc_security_group_ids = [var.aws_security_group_id_ent_ec2_sg]

  user_data = base64encode(templatefile("${path.module}/install.sh.tftpl", {
  html_content = file("${path.module}/index.html")
}))

  tags = {
    Name        = "ent-${terraform.workspace}-launch-template"
    Environment = terraform.workspace
  }
  
}

resource "aws_lb" "ent_alb" {
  name               = "ent-${terraform.workspace}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.aws_security_group_id_ent_alb_sg]
  subnets            = var.ent_public_subnet_ids

  enable_deletion_protection = false

  enable_http2 = true

  tags = {
    Name        = "ent-${terraform.workspace}-alb"
    Environment = terraform.workspace
  }
  
}

resource "aws_autoscaling_group" "ent_asg" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier = var.ent_public_subnet_ids
  launch_template {
    id      = aws_launch_template.ent_launch_template.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.ent_tg.arn]
  

  tag {
    key                 = "Name"
    value               = "ent-${terraform.workspace}-asg-instance"
    propagate_at_launch = true
  }
  
}

resource "aws_lb_listener" "ent_alb_listener" {
  load_balancer_arn = aws_lb.ent_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ent_tg.arn
  }
  
}