resource "google_compute_network" "network" {
  name                    = "BCWResearch-Network"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name                     = "BCWResearch-Subnetwork"
  ip_cidr_range            = "10.0.0.0/16"  # Main CIDR range for the subnet
  network                  = google_compute_network.network.self_link
  private_ip_google_access = true
  region                   = "southamerica-east1"

  secondary_ip_range {
    range_name    = "BCWResearch-SecondaryRange1"
    ip_cidr_range = "10.1.0.0/20"  # Secondary CIDR range for Pods
  }

  secondary_ip_range {
    range_name    = "BCWResearch-SecondaryRange2"
    ip_cidr_range = "10.2.0.0/20"  # Secondary CIDR range for Services
  }
}