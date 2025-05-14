terraform {
    required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.6.0"
    }
  }
  backend "s3" {
    bucket = "terra-remote-bucket--004"
    region = "us-east-1"
    key = "terraform.tfstate"
    dynamodb_table = "Terra-Remote-DB-table--004"
  }
}