resource "google_compute_network" "network" {
  name                    = "bcwresearch-network"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name                     = "bcwresearch-subnetwork"
  ip_cidr_range            = "10.0.0.0/16"
  network                  = google_compute_network.network.self_link
  private_ip_google_access = true
  region                   = local.region

  secondary_ip_range {
    range_name    = "bcwresearch-secondaryrange1"
    ip_cidr_range = "10.1.0.0/20"
  }

  secondary_ip_range {
    range_name    = "bcwresearch-secondaryrange2"
    ip_cidr_range = "10.2.0.0/20"
  }
}
