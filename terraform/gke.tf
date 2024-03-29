resource "google_container_cluster" "kubernetes-cluster" {
  name     = "kubernetes-cluster"
  location = local.zone

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }

  network    = google_compute_network.network.self_link
  subnetwork = google_compute_subnetwork.subnetwork.self_link
}

resource "google_container_node_pool" "app_pool" {
  name       = "app-pool"
  location   = local.zone
  cluster    = google_container_cluster.kubernetes-cluster.name
  node_count = 1

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
