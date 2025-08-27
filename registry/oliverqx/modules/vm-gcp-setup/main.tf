terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  zone    = var.zone
}

resource "google_compute_instance" "vm" {
  name         = var.instance_name
  machine_type = "n2-standard-4"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 50 # GiB
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["standard-workspace"]
}