terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=3.78.0"
    }
  }

  required_version = ">= 1.0.9"
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}
