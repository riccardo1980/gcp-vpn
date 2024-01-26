variable "project" {
  type = string
  description = "project identifier"
}

variable "region" {
  type = string
  description = "deployment GCP region"
}

variable "zone" {
  type = string
  description = "deployment GCP zone"
}

variable "credentials_file" {
  type = string
  sensitive = true
  description = "terraform Service Account GCP credentials file"
}

# COMPUTE
variable "vpc-service-name" {
  type = string
  description = "vpc-service name"
}

variable "vpc-service-machine-type" {
  type = string
  description = "vpc-service machine type"
}

variable "vpc-service-boot-disk-image" {
  type = string
  description = "vpc-service boot disk image"
}

variable "vpc-service-boot-disk-size" {
  type = string
  description = "vpc-service boot disk size"
}

# NETWORKING
variable "vpc-network-name" {
  type = string
  description = "vpc-service network name"
}

variable "vpc-subnet-name" {
  type = string
  description = "vpc subnet name"
}

variable "vpc-subnet-cidr-range" {
  type = string
  description = "vpc subnet cidr"
}