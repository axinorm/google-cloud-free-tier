resource "google_monitoring_notification_channel" "email" {
  project = module.external_services.project_id

  display_name = "personnal-email"
  type         = "email"

  labels = {
    email_address = var.notification_email
  }

  force_delete = false
}

resource "google_monitoring_alert_policy" "cpu_utilisation" {
  project = module.external_services.project_id

  display_name = "VM Instance - CPU utilization - ${var.instance_name}"
  combiner     = "OR"

  conditions {
    display_name = "VM Instance - CPU utilization"

    condition_threshold {
      filter     = "resource.type = \"gce_instance\" AND metric.type = \"compute.googleapis.com/instance/cpu/utilization\" AND metric.labels.instance_name = \"${var.instance_name}\""
      duration   = "300s"
      comparison = "COMPARISON_GT"

      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
      }

      threshold_value = 0.8
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email.name
  ]

  user_labels = {
    app = var.instance_name
  }
}

resource "google_monitoring_uptime_check_config" "service" {
  project = module.external_services.project_id

  display_name = "Service Uptime Check"

  timeout = "10s"
  period  = "60s"

  http_check {
    path         = "/"
    port         = "443"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = module.external_services.project_id
      host       = var.uptime_check_url
    }
  }
}

resource "google_monitoring_alert_policy" "service" {
  project = module.external_services.project_id

  display_name = "Service Uptime Check"
  combiner     = "OR"

  conditions {
    display_name = "Service Uptime Check"

    condition_threshold {
      filter = format(
        "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND metric.label.\"check_id\"=\"%s\" AND resource.type=\"uptime_url\""
        , google_monitoring_uptime_check_config.service.uptime_check_id
      )
      duration        = "600s"
      comparison      = "COMPARISON_GT"
      threshold_value = "1"

      trigger {
        count = 1
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email.name
  ]

  user_labels = {
    app = var.instance_name
  }
}