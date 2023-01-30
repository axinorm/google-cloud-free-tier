resource "google_service_account" "external_services" {
  project = module.external_services.project_id

  account_id   = "external-services"
  display_name = "Compte de service pour les services externes"
}

resource "google_storage_bucket_iam_binding" "binding" {
  bucket = google_storage_bucket.backup.name
  role   = "roles/storage.objectAdmin"

  members = [
    "serviceAccount:${google_service_account.external_services.email}",
  ]
}