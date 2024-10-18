terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.72.0"
    }
    porkbun = {
      source  = "kyswtn/porkbun"
      version = "0.1.2"
    }
  }
}

## Note: `PORKBUN_API_KEY` and `PORKBUN_SECRET_API_KEY` are not getting correctly read from env vars,
## therefore I decided to put them in SSM Parameter Store and read them from there.
data "aws_ssm_parameter" "api_key" {
  name = var.ssm_porkbun_api_key
}
data "aws_ssm_parameter" "secret_api_key" {
  name = var.ssm_porkbun_secret_key
}
provider "porkbun" {
  api_key        = data.aws_ssm_parameter.api_key.value
  secret_api_key = data.aws_ssm_parameter.secret_api_key.value
}


provider "aws" {
  region = var.region
  default_tags {
    tags = local.tags
  }
}

data "aws_caller_identity" "current" {}

locals {
  tags = merge({
    "managed-by" : "terraform"
  }, var.tags)
}
