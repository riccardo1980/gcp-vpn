terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.0.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project = var.project
  region = var.region
  zone = var.zone
}

resource "google_compute_instance" "vpc_service" {
    name = var.vpc-service-name
    machine_type = "f1-micro"
    zone = var.zone
    tags = ["http-server"]

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        network = "default"
        access_config {
            // Ephemeral public IP
        }
    }
}
