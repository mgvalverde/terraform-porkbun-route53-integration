variable "app_name" {
  type = string
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "domain" {
  type = string
  description = "Domain"
}
variable "subdomain" {
  type = string
  description = "Subdomain name"
}
variable "ssm_porkbun_api_key" {
  type = string
  description = "SSM Parameter for the API key"
  default = "/porkbun/api_key"
}
variable "ssm_porkbun_secret_key" {
  type = string
  description = "SSM PArameter for the API Secret key"
  default = "/porkbun/secret_key"
}
