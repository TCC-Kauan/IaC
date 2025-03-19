module "app_stage_1" {
  source = "../../../modules/services/ecr"

  name                 = "app_stage_1"
  image_tag_mutability = "MUTABLE"
  scan_on_push         = true
}
