/**

**/

variable "vpc_id" {}
variable "subnet_ids" {}
variable "allowed_cidr_blocks" {}

module "alb" {
  source = "../../../modules/services/load_balancer"

  alb_name            = ""
  vpc_id              = var.vpc_id
  subnet_ids          = [var.subnet_ids]
  allowed_cidr_blocks = [var.allowed_cidr_blocks]



}
