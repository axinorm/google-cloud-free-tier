output "project_id" {
  value = module.external_services.project_id
}

output "external_ip" {
  value = google_compute_instance.external_services.network_interface.0.access_config.0.nat_ip
}