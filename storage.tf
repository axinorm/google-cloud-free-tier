resource "google_storage_bucket" "backup" {
  project = module.external_services.project_id

  name          = "${module.external_services.project_id}-backup"
  location      = var.region
  storage_class = "REGIONAL"

  public_access_prevention = "enforced"
  force_destroy            = false

  lifecycle_rule {
    condition {
      age = 10
    }
    action {
      type = "Delete"
    }
  }
}