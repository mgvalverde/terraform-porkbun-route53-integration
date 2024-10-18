module "subdomain" {
  source = "./modules/subdomain"

  domain = var.domain
  subdomain = var.subdomain
}