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
