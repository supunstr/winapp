terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "terraform-state-winapp2"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock-dynamo"
  }

}