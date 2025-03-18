variable "service_name" {
  type        = string
  description = "Name of the service."
}

variable "cluster_name" {
  type        = string
  description = "ARN of an ECS cluster."
}

variable "task_definition_family" {
  type        = string
  description = "A unique name for your task definition."
}

variable "task_definition_network_mode" {
  type        = string
  description = "Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host."
}

variable "task_definition_cpu" {
  type        = string
  description = "Number of cpu units used by the task."
}

variable "task_definition_memory" {
  type        = string
  description = "Amount (in MiB) of memory used by the task."
}

variable "task_definition_requires_compatibilities" {
  type        = set(string)
  description = "Set of launch types required by the task. The valid values are EC2 and FARGATE."
}

variable "task_definition_container_definitions" {
  type        = string
  description = "A list of valid container definitions provided as a single valid JSON document."
}

variable "security_group_vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "service_desired_count" {
  type        = number
  description = "Number of instances of the task definition to place and keep running. Defaults to 0."
}

variable "service_launch_type" {
  type        = string
  description = "Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL. Defaults to EC2."
}

variable "service_health_check_grace_period_seconds" {
  type        = number
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown."
}

variable "network_configuration_subnets" {
  type        = set(string)
  description = "Network configuration for the service."
}

variable "load_balancer_target_group_arn" {
  type        = string
  description = "ARN of the Load Balancer target group to associate with the service."
}

variable "load_balancer_container_name" {
  type        = string
  description = "Name of the container to associate with the load balancer."
}

variable "load_balancer_container_port" {
  type        = number
  description = "Port on the container to associate with the load balancer."
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to assign to the object."
}
