resource "google_compute_network" "network" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnetwork_name
  ip_cidr_range = var.ip_range_nodes
  region        = var.region
  network       = google_compute_network.network.id
  
  secondary_ip_range {
    range_name    = "${var.cluster_name}-services-cidr"
    ip_cidr_range = var.ip_range_services
  }

  secondary_ip_range {
    range_name    = "${var.cluster_name}-pods-cidr"
    ip_cidr_range = var.ip_range_pods
  }
}