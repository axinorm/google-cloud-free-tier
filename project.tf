data "google_folder" "folder" {
  folder = "folders/${var.folder_id}"
}

data "google_organization" "organization" {
  domain = var.org_domain_name
}

module "external_services" {
  source  = "terraform-google-modules/project-factory/google"
  version = "14.1.0"

  name                     = var.project_name
  org_id                   = data.google_organization.organization.org_id
  folder_id                = data.google_folder.folder.folder_id
  random_project_id        = true
  random_project_id_length = 2

  auto_create_network = false

  billing_account = var.billing_account_id

  activate_apis = [
    "iam.googleapis.com",
    "compute.googleapis.com",
    "billingbudgets.googleapis.com"
  ]

  budget_amount            = var.billing_amount
  budget_alert_spend_basis = "CURRENT_SPEND"
  budget_alert_spent_percents = [
    0.1,
    0.25,
    0.5,
    0.75,
    1
  ]

  default_service_account = "disable"
}
