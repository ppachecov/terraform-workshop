resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.master.name
}

resource "google_sql_database_instance" "master" {
  name                = "${var.workshop_user}-db-instance"
  database_version    = "POSTGRES_11"
  region              = "us-east1"
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
  }

  timeouts {
    create = "60m"
    delete = "2h"
  }
}

resource "random_id" "user-password" {
  keepers = {
    name = google_sql_database_instance.master.name
  }

  byte_length = 8
  depends_on  = [google_sql_database_instance.master]
}

resource "google_sql_user" "default" {
  name       = var.db_username
  instance   = google_sql_database_instance.master.name
  password   = random_id.user-password.hex
  depends_on = [google_sql_database_instance.master]
}