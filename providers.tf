terraform {
  required_providers {
    google = {
      source  = "google"
      version = "~> 4.44.1"
    }
  }
}

provider "google" {
  impersonate_service_account = var.terraform_service_account
}