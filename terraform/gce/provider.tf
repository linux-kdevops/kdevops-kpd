terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>5"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.gce_project
  region      = var.gce_region
  zone        = var.gce_zone
}
