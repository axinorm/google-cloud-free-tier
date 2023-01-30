variable "project_name" {
  type        = string
  description = "The project name to create"
}

variable "region" {
  type        = string
  description = "The Google Cloud region"
}

variable "zone" {
  type        = string
  description = "The Google Cloud zone"
}

variable "machine_type" {
  type        = string
  description = "The compute instance machine type"
}

variable "image" {
  type        = string
  description = "The image name for compute engine instance"
}

variable "disk_size" {
  type        = string
  description = "The disk boot size for compute engine instance"
}

variable "instance_name" {
  type        = string
  description = "The instance name"
}

variable "billing_amount" {
  type        = string
  description = "The billing amount threshold"
}

variable "terraform_service_account" {
  type        = string
  description = "The Terraform service account to deploy infrastructure"
}

variable "folder_id" {
  type        = number
  description = "The personnal project ID"
}

variable "org_domain_name" {
  type        = string
  description = "The organisation domain name"
}

variable "billing_account_id" {
  type        = string
  description = "The billing account ID"
}

variable "network_name" {
  type        = string
  description = "The VPC network name"
}

variable "subnet_name" {
  type        = string
  description = "The subnetwork name"
}

variable "subnet_cidr" {
  type        = string
  description = "The subnetwork cidr range"
}

variable "uptime_check_url" {
  type        = string
  description = "The service url to watch"
}

variable "notification_email" {
  type        = string
  description = "Personnal email to receive monitoring notifications"
}