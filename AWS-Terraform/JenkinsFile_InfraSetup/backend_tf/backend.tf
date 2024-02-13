provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "s3-backend-tf"

  tags = {
    Name        = "s3-backend-tf"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name           = "demo-dynamodb-tf" 
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "demo-dynamodb-tf"
  }
}

output "table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}