module "subdomains" {
  source = "../../modules/subdomain"

  domain = var.domain
  subdomain = var.subdomain
}