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
