terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
  access_key = "AKIARXLOLKIKTDJWIQXH"
  secret_key = "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"
}