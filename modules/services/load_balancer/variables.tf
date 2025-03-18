variable "name" {
  type        = string
  description = "Name of the LB."
}

variable "internal" {
  type        = bool
  description = "If true, the LB will be internal."
}

variable "load_balancer_type" {
  type        = string
  description = "Type of load balancer to create. Possible values are application, gateway, or network."
}

variable "security_groups" {
  type        = set(string)
  description = " List of security group IDs to assign to the LB. Only valid for Load Balancers of type application or network."
}

variable "subnets" {
  type        = set(string)
  description = " List of subnet IDs to attach to the LB."
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to assign to the resource."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks"
}
