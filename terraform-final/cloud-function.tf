resource "google_storage_bucket" "bucket" {
  name = "${var.workshop_user}-bucket"
}

resource "google_storage_bucket_object" "archive" {
  name          = "index.zip"
  bucket        = google_storage_bucket.bucket.name
  source        = "./code/index.zip"
  cache_control = "no-cache"
}

resource "google_cloudfunctions_function" "function" {
  name        = "function-${var.workshop_user}"
  description = "Hello world function for workshop"
  runtime     = "nodejs14"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "helloGET"

  environment_variables = {
    DB_NAME     = var.db_name
    DB_USER     = google_sql_user.default.name
    DB_PASSWORD = random_id.user-password.hex
    DB_HOST     = google_sql_database_instance.master.connection_name
  }
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
