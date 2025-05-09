/**

**/

variable "vpc_id" {}
variable "subnet_ids" {}
variable "allowed_cidr_blocks" {}
variable "target_group_arn" {}

module "ecs_1" {
  source = "../../../modules/services/ecs"

  task_definition_family                   = ""
  task_definition_network_mode             = ""
  task_definition_cpu                      = 0
  task_definition_container_definitions    = ""
  task_definition_memory                   = 0
  task_definition_requires_compatibilities = [""]

  cluster_name                              = ""
  service_name                              = ""
  service_desired_count                     = 0
  service_launch_type                       = ""
  service_health_check_grace_period_seconds = 0

  load_balancer_container_name   = "my-application"
  load_balancer_target_group_arn = var.target_group_arn
  load_balancer_container_port   = 80

  vpc_id              = var.vpc_id
  subnet_ids          = var.subnet_ids
  allowed_cidr_blocks = var.allowed_cidr_blocks
}
