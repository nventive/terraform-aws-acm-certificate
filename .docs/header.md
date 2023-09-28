![nventive](https://nventive-public-assets.s3.amazonaws.com/nventive_logo_github.svg?v=2)

# terraform-aws-acm-certificate

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg?style=flat-square)](LICENSE) [![Latest Release](https://img.shields.io/github/release/nventive/terraform-aws-acm-certificate.svg?style=flat-square)](https://github.com/nventive/terraform-aws-acm-certificate/releases/latest)

Terraform module to request or import an ACM certificate.

---

## Providers

This modules uses two instances of the AWS provider. One for Route 53 resources and one for the rest. The reason why is
that Route 53 is often in a different account (ie. in the prod account when creating resources for dev).

You must provide both providers, whether you use Route 53 or not. In any case, you can specify the same provider for
both if need be.

## Examples

**IMPORTANT:** We do not pin modules to versions in our examples because of the difficulty of keeping the versions in
the documentation in sync with the latest released versions. We highly recommend that in your code you pin the version
to the exact version you are using so that your infrastructure remains stable, and update versions in a systematic way
so that they do not catch you by surprise.

To request an ACM certificate.

```hcl
module "cert" {
  source = "nventive/acm-certificate/aws"
  # We recommend pinning every module to a specific version
  # version = "x.x.x"

  namespace = "eg"
  stage     = "test"
  name      = "app"

  providers = {
    aws.acm     = aws.acm
    aws.route53 = aws.route53
  }

  type                        = "request"
  wait_for_certificate_issued = true
  domain_name                 = "example.com"
  validation_method           = "DNS"
  zone_name                   = "example.com"
}
```

To import a certificate in ACM.

```hcl
module "cert" {
  source = "nventive/acm-certificate/aws"
  # We recommend pinning every module to a specific version
  # version = "x.x.x"

  namespace = "eg"
  stage     = "test"
  name      = "app"

  providers = {
    aws = aws.acm
  }

  type                     = "import"
  private_key_base64       = filebase64("${path.module}/key.pem")
  certificate_body_base64  = filebase64("${path.module}/cert.pem")
  certificate_chain_base64 = filebase64("${path.module}/chain.pem")
}
```

Should you want to use the same AWS provider for both Route 53 and the default one.

```hcl
module "cert" {
  source = "nventive/acm-certificate/aws"
  # We recommend pinning every module to a specific version
  # version = "x.x.x"

  providers = {
    aws.acm     = aws.acm
    aws.route53 = aws.acm
  }

  # ...
}
```
