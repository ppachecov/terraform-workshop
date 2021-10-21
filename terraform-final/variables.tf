variable "project_id" {
  description = "Google project id"
}

variable "region" {
  default     = "us-east1"
  description = "Google availability region"
}

variable "zone" {
  default     = "us-east1-c"
  description = "Google availability zone whitin a region"
}

variable "db_name" {
  default     = "workshop-test"
  description = "DB name"
}

variable "db_username" {
  default     = "test"
  description = "DB user name"
}

variable "workshop_user" {
  description = "DB user name"
}
