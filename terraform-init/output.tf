output "workshop_keys" {
  sensitive = true
  value     = module.service-accounts.keys
}