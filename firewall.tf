module "network_firewall_rules" {
  source  = "terraform-google-modules/network/google//modules/firewall-rules"
  version = "6.0.0"

  project_id   = module.external_services.project_id
  network_name = module.network_vpc.network_name

  rules = [
    {
      name                    = "frw-allow-web"
      description             = null
      direction               = "INGRESS"
      priority                = null
      ranges                  = ["0.0.0.0/0"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = ["external-services"]
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["80", "443"]
      }]
      deny       = []
      log_config = null
    },
    # A décommenter uniquement pour les tâches d'administration
    # {
    #   name                    = "frw-allow-ssh-from-iap"
    #   description             = null
    #   direction               = "INGRESS"
    #   priority                = null
    #   ranges                  = ["35.235.240.0/20"]
    #   source_tags             = null
    #   source_service_accounts = null
    #   target_tags             = ["external-services"]
    #   target_service_accounts = null
    #   allow = [{
    #     protocol = "tcp"
    #     ports    = ["22"]
    #   }]
    #   deny       = []
    #   log_config = null
    # }
  ]
}
