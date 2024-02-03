terraform {
  required_version = "~> 1.5"
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
  
  network    = "projects/${local.project_id}/global/networks/bcwresearch-network" # Replace with your network's self-link
  subnetwork = "projects/${local.project_id}/regions/${local.region}/subnetworks/bcwresearch-subnetwork" # Replace with your subnetwork's self-link
}

resource "google_container_node_pool" "app_pool" {
  name       = "app-pool"
  location   = local.region
  cluster    = google_container_cluster.helloweb3.name
  node_count = 3

  node_config {
    preemptible  = false
    machine_type = "n1-standard-1"
    disk_size_gb = 100
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}