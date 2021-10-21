terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=3.88.0"
    }
  }

  required_version = ">= 1.0.9"
}

provider "google" {
  project = var.project_id
  region  = "us-east1"
  zone    = "us-east1-c"
}
