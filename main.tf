module "import" {
  source  = "nventive/acm-certificate-import/aws"
  version = "1.0.0"
  count   = var.type == "import" ? 1 : 0

  providers = { aws = aws.acm }

  private_key_base64       = var.private_key_base64
  certificate_body_base64  = var.certificate_body_base64
  certificate_chain_base64 = var.certificate_chain_base64

  context = module.this.context
}

module "request" {
  source  = "nventive/acm-certificate-request/aws"
  version = "1.0.0"
  count   = var.type == "request" ? 1 : 0

  providers = {
    aws.route53 = aws.route53
    aws.acm     = aws.acm
  }

  wait_for_certificate_issued                 = var.wait_for_certificate_issued
  domain_name                                 = var.domain_name
  validation_method                           = var.validation_method
  process_domain_validation_options           = var.process_domain_validation_options
  ttl                                         = var.ttl
  subject_alternative_names                   = var.subject_alternative_names
  zone_name                                   = var.zone_name
  zone_id                                     = var.zone_id
  certificate_transparency_logging_preference = var.certificate_transparency_logging_preference

  context = module.this.context
}
