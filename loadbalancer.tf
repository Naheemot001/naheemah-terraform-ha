resource "aws_lb" "naheemah_ha_lb" {
  name                       = "naheemah-ha-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.naheemah_ha_sg.id]
  subnets                    = var.subnet_ids
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "naheemah_lb_target_group" {
  name        = "naheemah-ha-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    port                = 80
  }

}
resource "aws_lb_listener" "naheemah_lb_listener_http" {
  load_balancer_arn = aws_lb.naheemah_ha_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.naheemah_lb_target_group.arn
  }

}

resource "aws_lb_listener" "naheemah_lb_listener_https" {
  load_balancer_arn = aws_lb.naheemah_ha_lb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn = aws_acm_certificate_validation.naheemah_cert_validation.certificate_arn

depends_on = [
  aws_acm_certificate_validation.naheemah_cert_validation
]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.naheemah_lb_target_group.arn
  }

}