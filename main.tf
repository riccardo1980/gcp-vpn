terraform {
  required_version = ">= 1.7" 
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

# COMPUTE
resource "google_compute_instance" "vpc_service" {
  name = var.vpc-service-name
  machine_type = var.vpc-service-machine-type
  zone = var.zone

  tags = ["vpc-server"]
  boot_disk {
    initialize_params {
      image = var.vpc-service-boot-disk-image
      size = var.vpc-service-boot-disk-size
    }
  }

  can_ip_forward = true
  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.vpc_subnetwork.name
    
    access_config {
      network_tier = "STANDARD"
      // Ephemeral public IP
    }
  }
}

# NETWORK

resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
  routing_mode = "REGIONAL"
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "vpc_subnetwork" {
  name = "vpc-subnetwork"
  ip_cidr_range = "10.124.0.0/20"
  network = google_compute_network.vpc_network.name
  region = var.region
}

resource "google_compute_firewall" "vpc_firewall" {
  name = "vpc-firewall"
  network = google_compute_network.vpc_network.name
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports = ["22", "80", "443"]
  }
}
