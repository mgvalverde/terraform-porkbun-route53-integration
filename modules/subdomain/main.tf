locals {
  fqdn = "${var.subdomain}.${var.domain}"

}
resource "aws_route53_zone" "this" {
  name = local.fqdn
}

resource "null_resource" "always_run" {
  triggers = {
    timestamp = "${timestamp()}"
  }
}

resource "porkbun_dns_record" "ns" {
  for_each = {for i in toset(range(4)) : i => i}  # There are 4 NS records

  domain   = var.domain
  name     = var.subdomain
  type     = "NS"
  content  = aws_route53_zone.this.name_servers[each.value]
  ttl      = var.porkbun_ttl
  priority = 0
  notes    = var.porkbun_notes

  lifecycle {
    replace_triggered_by = [
      null_resource.always_run
    ]
  }
}

