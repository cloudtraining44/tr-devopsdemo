terraform {
  backend "s3" {
    bucket = "tfbackendbucket05082023"
    key = "main"
    region = "us-east-1"
    dynamodb_table = "tf-db-backend"
  }
}