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

# COMPUTE
resource "google_compute_instance" "vpc_service" {
  name         = var.vpc-service-name
  machine_type = var.vpc-service-machine-type
  zone         = var.zone

  tags = ["allow-http", "allow-https", "allow-ssh", "allow-openvpn", "deny-all-ingress"]

  metadata = {
    ssh-keys = "terraform:${file(var.terraform_ssh_public_key_file)}"
  }

  boot_disk {
    initialize_params {
      image = var.vpc-service-boot-disk-image
      size  = var.vpc-service-boot-disk-size
    }
  }

  can_ip_forward = true
  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.vpc_subnetwork.name

    access_config {
      network_tier = "STANDARD"
      // Ephemeral public IP
    }
  }

  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "terraform"
      host        = self.network_interface[0].access_config[0].nat_ip
      private_key = file(var.terraform_ssh_private_key_file)
    }
    source      = "installer.sh"
    destination = "installer.sh"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "terraform"
      host        = self.network_interface[0].access_config[0].nat_ip
      private_key = file(var.terraform_ssh_private_key_file)
    }

    inline = [
      "touch iwashere.txt",
      "chmod u+x installer.sh",
      "sudo ./installer.sh"
    ]
  }

}

# NETWORK
resource "google_compute_network" "vpc_network" {
  name                    = var.vpc-network-name
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = var.vpc-subnet-name
  ip_cidr_range = var.vpc-subnet-cidr-range
  network       = google_compute_network.vpc_network.name
  region        = var.region
}

resource "google_compute_firewall" "allow_http" {
  name          = "allow-http"
  network       = google_compute_network.vpc_network.name
  target_tags   = ["allow-http"]
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

resource "google_compute_firewall" "allow_https" {
  name          = "allow-https"
  network       = google_compute_network.vpc_network.name
  target_tags   = ["allow-https"]
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}

resource "google_compute_firewall" "allow_openvpn" {
  name          = "allow-openvpn"
  network       = google_compute_network.vpc_network.name
  target_tags   = ["allow-openvpn"]
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "udp"
    ports    = ["1194"]
  }
}

resource "google_compute_firewall" "allow_ssh" {
  name          = "allow-ssh"
  network       = google_compute_network.vpc_network.name
  target_tags   = ["allow-ssh"]
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}


resource "google_compute_firewall" "deny_all_ingress" {
  name          = "deny-all-ingress"
  network       = google_compute_network.vpc_network.name
  direction     = "INGRESS"
  priority      = 65534
  source_ranges = ["0.0.0.0/0"]
  deny {
    protocol = "all"
  }
}
