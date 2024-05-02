module "rds" {
  source = "../../../modules/services/rds"

  allocated_storage    = ""
  engine               = ""
  storage_type         = ""
  password             = ""
  identifier           = ""
  instance_class       = ""
  db_name              = ""
  parameter_group_name = ""
  username             = ""
}