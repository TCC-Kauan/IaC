provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.63.0"
    }
  }
}

module "app_stage_1" {
  source = "../../../modules/services/ecr"

  name                 = "app_stage_1"
  image_tag_mutability = "MUTABLE"
  scan_on_push         = true

  tags = {
    Name = "App stage 1"
    Team = "Devs"
  }
}