provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }
  backend "s3" {
    bucket = "my-tcc-kauan"
    key = "resources/terraform.tfstate"
    region = "us-east-1"
  }
}


module "stage" {
  source = "./stage"
}

# module "prod" {
#   source = "./prod"
# }
