variable "base_name" {
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

variable "tags" {
  type        = map(string)
  description = "value"
}

variable "vpc_id" {
  type        = string
  description = ""
  default     = ""
}

variable "port_number" {
  type        = number
  description = ""
}

variable "vpc_cidr" {
  type        = string
  description = ""
  default     = ""
}

variable "accept_cidr_ranges" {
  type    = list(string)
  default = []
}

variable "private_subnets" {
  type        = list(string)
  description = ""
  default     = []
}

variable "parameter_group_family" {
  type        = string
  description = ""
  default     = null
}

variable "parameter_group_custom" {
  type        = list(map(string))
  description = ""
  default     = []
}

variable "option_group_major_engine_version" {
  type        = string
  description = ""
  default     = null
}

variable "option_group_custom" {
  type        = list(map(string))
  description = ""
  default     = []
}

variable "engine_version" {
  type        = string
  description = ""
}

variable "storage_encrypted" {
  type        = string
  description = ""
  default     = "gp3"
}

variable "max_allocated_storage" {
  type        = number
  description = ""
  default     = 5000
}

variable "availability_zones" {
  type        = set(string)
  description = ""
  default     = ["us-east-1"]
}

variable "multi_az" {
  type        = bool
  description = ""
  default     = false
}

variable "publicly_accessible" {
  type        = bool
  description = ""
  default     = false
}

variable "allow_major_version_upgrade" {
  type        = bool
  description = ""
  default     = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = ""
  default     = true
}

variable "apply_immediately" {
  type        = bool
  description = ""
  default     = false
}

variable "maintenance_window" {
  type        = string
  description = ""
  default     = "Mon:00:00-Mon:03:00"
}

variable "backup_window" {
  type        = string
  description = ""
  default     = "03:00-06:00"
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = ""
  default     = []
}

variable "skip_final_snapshot" {
  type        = bool
  description = ""
  default     = true
}

variable "deletion_protection" {
  type        = bool
  description = ""
  default     = false
}

variable "performance_insights_enabled" {
  type        = bool
  description = ""
  default     = false
}

variable "performance_insights_retention_period" {
  type        = number
  description = ""
  default     = 7
}

variable "monitoring_interval" {
  type        = number
  description = ""
  default     = 60
}
