terraform_service_account = "" # Compte de service pour Terraform
folder_id                 = "" # ID du folder
org_domain_name           = "" # Domaine de l'organisation
project_name              = "services"

region        = "us-east1"
zone          = "us-east1-c"
machine_type  = "e2-micro"
image         = "debian-cloud/debian-11"
disk_size     = "30"
instance_name = "ci-external-services"

network_name = "vpc-external-services"
subnet_name  = "sne-external-services"
subnet_cidr  = "10.0.0.0/28"

billing_account_id = "" # ID du compte de facturation
billing_amount     = 1

uptime_check_url   = "" # Url du service à superviser
notification_email = "" # Email pour les notifications de supervision