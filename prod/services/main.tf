/*
  Resources Prod
*/

module "ecr" {
  source = "./ecr"
}

module "ecs" {
  source = "./ecs"
}

module "lambda" {
  source = "./lambda"
}

module "alb" {
  source = "./load_balancer"
}

module "rds" {
  source = "./rds"
}

module "vpc" {
  source = "./vpc"
}
