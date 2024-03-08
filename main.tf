terraform {
  required_version = ">= 1.7"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.13.0"
    }
  }
}

provider "google" {
  credentials = file(var.terraform_SA_credentials_file)
  project     = var.project
  region      = var.region
  zone        = var.zone
}
