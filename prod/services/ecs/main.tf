module "ecs_stage_1" {
  source = "../../../modules/services/ecs"

  task_definition_family                   = ""
  task_definition_network_mode             = ""
  task_definition_cpu                      = 0
  task_definition_container_definitions    = ""
  task_definition_memory                   = 0
  task_definition_requires_compatibilities = ""

  cluster_name                              = ""
  service_name                              = ""
  service_desired_count                     = 0
  service_launch_type                       = ""
  service_health_check_grace_period_seconds = 0

  load_balancer_container_name   = ""
  load_balancer_target_group_arn = ""
  load_balancer_container_port   = 0

  network_configuration_subnets = ""
  security_group_vpc_id         = ""
  allowed_cidr_blocks           = ""
}
