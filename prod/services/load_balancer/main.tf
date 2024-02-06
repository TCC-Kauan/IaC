module "aplication_load_balancer" {
  source = "../../../modules/services/load_balancer"

  name               = ""
  subnets            = [""]
  internal           = true
  load_balancer_type = "aplication"
  security_groups    = [""]

}