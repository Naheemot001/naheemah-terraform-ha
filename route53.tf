resource "aws_route53_record" "naheemah_route53_record" {
  zone_id = "Z017744921XM45LEYQ2D7"
  name    = "naheemah-demo-app.myajay.com"
  type    = "A"
  alias {
    name                   = aws_lb.naheemah_ha_lb.dns_name
    zone_id                = "ZQSVJUPU6J1EY"
    evaluate_target_health = true
  }
}