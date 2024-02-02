locals {
  project_id = "dotted-lens-412717"
  region     = "southamerica-east1"
  default_labels = {
    managed-by = "terraform"
  }
}

terraform {
  required_version = "~> 1.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.2"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.2"
    }
  }

  backend "gcs" {
    bucket = "lilteddybucketwhite"
  }
}

provider "google" {
  project = local.project_id
  region  = local.region
}

provider "google-beta" {
  project = local.project_id
  region  = local.region
}

resource "google_container_cluster" "helloweb3" {
  name     = "helloweb3"
  location = local.region

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }
}

resource "google_container_node_pool" "app_pool" {
  name       = "app-pool"
  location   = local.region
  cluster    = google_container_cluster.helloweb3.name
  node_count = 3

  node_config {
    preemptible  = false
    machine_type = "n1-standard-1"
    disk_size_gb = 66  # Aangepast om totaal schijfgebruik te beperken tot ongeveer 200 GB

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
