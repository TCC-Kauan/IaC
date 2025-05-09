/**

**/

module "vpc" {
  source = "../../../modules/services/vpc"

  vpc_cidr              = "10.10.0.0/24"
  private_subnet_1_cidr = "10.10.0.0/26"
  private_subnet_2_cidr = "10.10.0.64/26"
  public_subnet_1_cidr  = "10.10.0.128/26"
  public_subnet_2_cidr  = "10.10.0.192/26"
}

output "networking" {
  value = module.vpc
}
