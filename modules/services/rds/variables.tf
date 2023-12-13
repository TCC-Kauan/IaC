variable "identifier" {
  type        = string
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier."
}

variable "allocated_storage" {
  type        = number
  description = "The amount of allocated storage."
}

variable "storage_type" {
  type        = string
  description = "One of standard (magnetic), gp2 (general purpose SSD), gp3 (general purpose SSD that needs iops independently) or io1 (provisioned IOPS SSD)."
}

variable "engine" {
  type        = string
  description = "The database engine to use."
}

variable "instance_class" {
  type        = string
  description = "The RDS instance class."
}

variable "db_name" {
  type        = string
  description = "The database name."
}

variable "username" {
  type        = string
  description = "Username for the master DB user."
}

variable "password" {
  type        = string
  description = "Password for the master DB user."
  sensitive   = true
}

variable "parameter_group_name" {
  type        = string
  description = "Name of the DB parameter group to associate."
}
