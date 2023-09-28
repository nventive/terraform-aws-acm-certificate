output "id" {
  value       = join("", concat(module.request.*.id, module.import.*.id))
  description = "The ID of the certificate"
}

output "arn" {
  value       = join("", concat(module.request.*.arn, module.import.*.arn))
  description = "The ARN of the certificate"
}

output "domain_validation_options" {
  value       = module.request.*.domain_validation_options
  description = "CNAME records that are added to the DNS zone to complete certificate validation"
}

output "enabled" {
  value       = var.enabled
  description = "True if the module was enabled false otherwise"
}
