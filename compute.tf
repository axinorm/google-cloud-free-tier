resource "google_compute_address" "external_services" {
  project = module.external_services.project_id
  region  = var.region

  name         = "external-services-ip"
  address_type = "EXTERNAL"
}

resource "google_compute_instance" "external_services" {
  project = module.external_services.project_id

  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  can_ip_forward = "false"

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
      labels = {
        app = var.instance_name
      }
    }
  }

  network_interface {
    subnetwork = lookup(module.network_subnets.subnets, "${var.region}/${var.subnet_name}").self_link
    access_config {
      nat_ip = google_compute_address.external_services.address
    }
  }

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  service_account {
    email  = google_service_account.external_services.email
    scopes = ["cloud-platform"]
  }

  tags = ["external-services"]

  labels = {
    app = var.instance_name
  }
}
