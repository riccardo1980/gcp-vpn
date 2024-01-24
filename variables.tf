variable "project" {
  default = "formazione-riccardo-zanella"
}

variable "region" {
  default = "europe-west1"
}

variable "zone" {
  default = "europe-west1-b"
}

variable "credentials_file" {
    sensitive = true
    default = "./secrets/terraform-service-account.json"
}

variable "vpc-service-name" {
    default = "vpc-service"
}