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
