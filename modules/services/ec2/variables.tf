variable "ami" {
  type        = string
  description = "AMI to use for the instance."
}

variable "instance_type" {
  type        = string
  description = "Instance type to use for the instance."
}

variable "subnet_id" {
  type        = string
  description = ""
}
