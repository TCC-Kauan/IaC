variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "internal" {
  description = "Whether the ALB is internal"
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "target_group_name" {
  description = "Name of the Target Group"
  type        = string
  default     = "my-target-group"
}

variable "target_group_port" {
  description = "Port of the Target Group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol of the Target Group"
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "listener_port" {
  description = "Port of the ALB listener"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "Protocol of the ALB listener"
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/"
}

variable "health_check_port" {
  description = "Health check port"
  type        = string
  default     = "traffic-port"
}

variable "health_check_protocol" {
  description = "Health check protocol"
  type        = string
  default     = "HTTP"
}

variable "environment" {
  description = "Enviroment tag"
  type        = string
  default     = "dev"
}

variable "enable_deletion_protection" {
  description = "enable deletion protection"
  type        = bool
  default     = false
}


variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the load balancer"
  type        = list(string)
}
