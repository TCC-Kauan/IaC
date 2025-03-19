module "rds" {
  source = "../../../modules/services/rds"

  db_name             = ""
  db_username         = ""
  vpc_id              = ""
  subnet_ids          = [""]
  allowed_cidr_blocks = [""]
}
