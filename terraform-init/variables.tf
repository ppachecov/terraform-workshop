variable "gcp_project_id" {
  default     = ""
  description = "GCP project id"
}

variable "gcp_region" {
  default     = "us-east1"
  description = "GCP region where to deploy infrastructure"
}

variable "gcp_zone" {
  default     = "us-east1-c"
  description = "GCP availability zone for the infrastructure"
}

variable "environment" {
  default     = "test"
  description = "Environment flag"
}

variable "service_account_list" {
  default = [
    "test1",
    "test2",
  ]
}