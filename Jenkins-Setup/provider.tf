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
  access_key = "AKIA4P5QGTZM7URMM57U"
  secret_key = "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"
}