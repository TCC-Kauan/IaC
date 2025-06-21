/*
  Resources Production
*/

module "alb" {
  source              = "./load_balancer"
  vpc_id              = module.vpc.networking.vpc_id
  subnet_ids          = [module.vpc.networking.public_subnet_1_id, module.vpc.networking.public_subnet_1_id]
  allowed_cidr_blocks = [module.vpc.networking.vpc_cidr]
}

module "lambda" {
  source              = "./lambda"
  vpc_id              = module.vpc.networking.vpc_id
  subnet_ids          = [module.vpc.networking.private_subnet_1_id, module.vpc.networking.private_subnet_1_id]
  allowed_cidr_blocks = [module.vpc.networking.vpc_cidr]
  alb                 = module.alb.instance.arn
}

module "rds" {
  source              = "./rds"
  vpc_id              = module.vpc.networking.vpc_id
  subnet_ids          = [module.vpc.networking.private_subnet_1_id, module.vpc.networking.private_subnet_1_id]
  allowed_cidr_blocks = [module.vpc.networking.vpc_cidr]
}

module "vpc" {
  source = "./vpc"
}
