module "alb" {
  source = "../../../modules/services/load_balancer"

  alb_name            = ""
  subnet_ids          = ""
  vpc_id              = ""
  allowed_cidr_blocks = ""
}
