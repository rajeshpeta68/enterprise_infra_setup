/*
data "aws_route53_zone" "ent_r53" {
  name         = bnktmt.com
  private_zone = false
}

data "aws_lb" "ent_lb" {
  name = "ent-default-lb"
}

resource "aws_route53_record" "ent_dns_record" {
  zone_id = data.aws_route53_zone.ent_r53.zone_id
  name    = "bnktmt.com"
  type    = "A"

  alias {
    name                   = data.aws_lb.ent_lb.dns_name
    zone_id                = data.aws_lb.ent_lb.zone_id
    evaluate_target_health = true
  }
  
}*/