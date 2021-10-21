module "service-accounts" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "4.0.3"
  project_id    = var.gcp_project_id
  prefix        = "terraform-workshop-sa"
  names         = var.service_account_list
  generate_keys = true
  description   = "Terraform service account for terraform workshop, this sa should be a temporal service account"

  project_roles = [
    "${var.gcp_project_id}=>roles/editor",
    "${var.gcp_project_id}=>roles/cloudfunctions.developer",
    "${var.gcp_project_id}=>roles/storage.objectAdmin",
    "${var.gcp_project_id}=>roles/cloudsql.editor",
    "${var.gcp_project_id}=>cloudsql.instances.create",
    "${var.gcp_project_id}=>cloudsql.users.create",
    "${var.gcp_project_id}=>cloudsql.users.list",
  ]
}