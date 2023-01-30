module "network_vpc" {
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "6.0.0"

  project_id   = module.external_services.project_id
  network_name = var.network_name

  auto_create_subnetworks = false
}

module "network_subnets" {
  source  = "terraform-google-modules/network/google//modules/subnets"
  version = "6.0.0"

  project_id   = module.external_services.project_id
  network_name = module.network_vpc.network_name

  subnets = [
    {
      subnet_name           = var.subnet_name
      subnet_ip             = var.subnet_cidr
      subnet_region         = var.region
      subnet_private_access = true
      subnet_flow_logs      = false
    },
  ]
}
