terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
  }
  backend "s3" {
    bucket = "api-lambda-dynamodb-demo" # change to name of your bucket
    region = "us-east-1"                   # change to your region
    key    = "terraform.tfstate"
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_dynamodb_table" "questions" {
  name           = "questions"
  billing_mode   = "PAY_PER_REQUEST" # PAY_PER_REQUEST or PROVISIONED
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
