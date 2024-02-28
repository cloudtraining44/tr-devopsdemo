variable "port" {
  default = "5432"
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "14"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.medium"
}

variable "multi_az" {
  type    = bool
  default = true
}

variable "publicly_accessible" {
  type    = bool
  default = true
}

variable "db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = "database1"
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = "pgdb"
}


variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (new generation of general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. If you specify 'io1' or 'gp3' , you must also include a value for the 'iops' parameter"
  type        = string
  default     = "gp3"
}

variable "max_allocated_storage" {
  default = "100"
}

variable "maintenance_window" {
  default = "Mon:00:00-Mon:03:00"
}

variable "enabled_cloudwatch_logs_exports" {
  type    = list(any)
  default = ["postgresql", "upgrade"]
}

variable "performance_insights_enabled" {
  type    = bool
  default = true
}

variable "performance_insights_retention_period" {
  default = "7"

}

variable "deletion_protection" {
  type    = bool
  default = false
}

variable "delete_automated_backups" {
  type    = bool
  default = true
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}