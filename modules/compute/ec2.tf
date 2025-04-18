resource "aws_lb_target_group" "ent_tg" {
  name     = "ent-${terraform.workspace}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ent_vpc.id

  health_check {
    healthy_threshold   = 3
    interval            = 30
    timeout             = 5
    target              = "HTTP:80/"
    unhealthy_threshold = 3
  }

  tags = {
    Name        = "ent-${terraform.workspace}-tg"
    Environment = terraform.workspace
  }
}