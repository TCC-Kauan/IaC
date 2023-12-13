variable "name" {
  type        = string
  description = ""
}

variable "internal" {
  type        = bool
  description = ""
}

variable "load_balancer_type" {
  type        = string
  description = ""
}

variable "security_groups" {
  type        = set(string)
  description = ""
}

variable "subnets" {
  type        = set(string)
  description = ""
}
