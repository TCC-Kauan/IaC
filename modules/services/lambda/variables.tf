variable "lambda_function_name" {
  type        = string
  description = "Unique name for your Lambda Function."
}

variable "lambda_function_handler" {
  type        = string
  description = "Function entrypoint in your code."
}

variable "lambda_function_runtime" {
  type        = string
  description = "Identifier of the function's runtime."
}

variable "lambda_function_memory_size" {
  type        = number
  description = "Amount of memory in MB your Lambda Function can use at runtime."
}

variable "lambda_function_timeout" {
  type        = number
  description = "Amount of time your Lambda Function has to run in seconds."
}

variable "lambda_function_architectures" {
  type        = list(string)
  description = "Instruction set architecture for your Lambda function. Valid values are ['x86_64'] and ['arm64']."
}

variable "lambda_function_layers" {
  type        = list(string)
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function."
}

variable "lambda_function_variables" {
  type        = map(string)
  description = "Map of environment variables that are accessible from the function code during execution."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnets_ids" {
  type        = set(string)
  description = "List of subnet IDs associated with the Lambda function."
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the load balancer"
  type        = list(string)
}

variable "alb" {
  description = ""
  type        = string
}

variable "priority" {
  description = ""
  type        = number
  default     = 1
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
