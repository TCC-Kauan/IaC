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

module "ecs_stage_1" {
  source = "../../../modules/services/ecs"

    
}