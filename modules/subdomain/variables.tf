variable "domain" {
  type = string
  description = "Main domain"
}

variable "subdomain" {
  type = string
  description = "Subdomain name. Eg: api, www, prod"
}

variable "porkbun_ttl" {
  type = number
  default = 600
  description = "Porkbun TTL"
}

variable "porkbun_notes" {
  type = string
  default = "Route 53 NS"
  description = "Porkbun DNS Record note"
}
