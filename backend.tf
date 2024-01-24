terraform {
    backend "gcs" {
        bucket = "formazione-riccardo-zanella-tfstate-bucket"
        prefix = "terraform/state"
    }
}