/**

**/

module "app" {
  source = "../../../modules/services/ecr"

  name                 = "my-app"
  image_tag_mutability = "MUTABLE"
  scan_on_push         = true
}
