provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "demo-instance" {
for_each = var.instance_attr

ami = each.value.ami
instance_type = each.value.instance_type
  
  tags = {
	Name  = var.env == "prod" || var.env == "qa"? "${var.env}-${var.name}" : "dev-${var.name}"
	Owner = "Terraform"
  }
}