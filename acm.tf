resource "aws_acm_certificate" "naheemah_acm_cert" {
  domain_name       = "myajay.com"
  validation_method = "DNS"
  
  lifecycle {
    create_before_destroy = true
  }
}