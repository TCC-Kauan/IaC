/**

**/

variable "vpc_id" {}
variable "subnet_ids" {}
variable "allowed_cidr_blocks" {}


module "rds" {
  source = "../../../modules/services/rds"

  db_name             = ""
  db_username         = ""
  vpc_id              = var.vpc_id
  subnet_ids          = [var.subnet_ids]
  allowed_cidr_blocks = [var.allowed_cidr_blocks]
}
