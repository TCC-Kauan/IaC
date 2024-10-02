variable "service_name" {
  type        = string
  description = ""
}

variable "cluster_name" {
  type        = string
  description = ""
}

variable "task_definition_family" {
  type        = string
  description = ""
}

variable "task_definition_network_mode" {
  type        = string
  description = ""
}

variable "task_definition_cpu" {
  type        = string
  description = ""
}

variable "task_definition_memory" {
  type        = string
  description = ""
}

variable "task_definition_requires_compatibilities" {
  type        = set(string)
  description = ""
}

variable "task_definition_container_definitions" {
  type        = string
  description = ""
}

variable "security_group_vpc_id" {
  type        = string
  description = ""
}

variable "service_desired_count" {
  type        = number
  description = ""
}

variable "service_launch_type" {
  type        = string
  description = ""
}

variable "service_health_check_grace_period_seconds" {
  type        = number
  description = ""
}

variable "network_configuration_subnets" {
  type        = set(string)
  description = ""
}

variable "load_balancer_target_group_arn" {
  type        = string
  description = ""
}

variable "load_balancer_container_name" {
  type        = string
  description = ""
}

variable "load_balancer_container_port" {
  type        = number
  description = ""
}

variable "tags" {
  type        = map(string)
  description = ""
}
