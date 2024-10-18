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
  backend "s3" {
    encrypt = true
  }
}

data "aws_ssm_parameter" "api_key" {
  name = var.ssm_porkbun_api_key
}
data "aws_ssm_parameter" "secret_api_key" {
  name = var.ssm_porkbun_secret_key
}

# REQ ENV VARS: PORKBUN_API_KEY & PORKBUN_SECRET_API_KEY
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

  account_id = data.aws_caller_identity.current.account_id
  region     = var.region
  app_name = coalesce(var.app_name, "my-app")
}
