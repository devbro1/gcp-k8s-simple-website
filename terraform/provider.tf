terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.15.0"
    }
  }
}

provider "google" {
  project     = "gorgias-devbro"
  region      = "us-east1"
}
