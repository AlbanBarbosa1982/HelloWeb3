provider "google" {
  credentials = file("/Users/Alban/Werk/HelloWeb3/traffic-386513-0f741ebb862c.json")
  project     = "dotted-lens-412717"
  region      = "southamerica-east1"
}

resource "google_container_cluster" "helloweb3" {
  name     = "helloweb3"
  location = "southamerica-east1"

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
  location   = "southamerica-east1"
  cluster    = google_container_cluster.helloweb3.name
  node_count = 3

  node_config {
    preemptible  = false
    machine_type = "n1-standard-1"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
