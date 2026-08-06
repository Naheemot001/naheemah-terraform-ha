resource "aws_acm_certificate" "naheemah_acm_cert" {
  domain_name       = "naheemah-demo-app.myajay.com"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "naheemah_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.naheemah_acm_cert.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  zone_id         = "Z017744921XM45LEYQ2D7"

  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "naheemah_cert_validation" {
  certificate_arn = aws_acm_certificate.naheemah_acm_cert.arn

  validation_record_fqdns = [
    for record in aws_route53_record.naheemah_cert_validation :
    record.fqdn
  ]
}