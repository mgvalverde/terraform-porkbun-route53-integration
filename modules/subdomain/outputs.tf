output "fqdn" {
  description = "Fully Qualified Domain Name"
  value = local.fqdn
}
output "ns" {
  description = "NS"
  value = aws_route53_zone.this.name_servers
}