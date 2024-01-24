output "vpc_service_public_ip_addr" {
  value = google_compute_instance.vpc_service.network_interface.0.access_config.0.nat_ip
}