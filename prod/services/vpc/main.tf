module "vpc" {
  source = "../../../modules/services/vpc"

  vpc_cidr              = ""
  private_subnet_1_cidr = ""
  private_subnet_2_cidr = ""
  public_subnet_1_cidr  = ""
  public_subnet_2_cidr  = ""
}
