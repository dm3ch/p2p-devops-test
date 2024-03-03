module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 30.0"

  project_id                  = var.project_id
  name                        = var.cluster_name
  regional                    = true
  region                      = var.region
  network                     = google_compute_network.network.name
  subnetwork                  = google_compute_subnetwork.subnetwork.name
  ip_range_pods               = "${var.cluster_name}-pods-cidr"
  ip_range_services           = "${var.cluster_name}-services-cidr"
}

resource "google_artifact_registry_repository_iam_member" "gke-pull-docker" {
  location      = var.region
  repository = google_artifact_registry_repository.docker_repository.id
  role = "roles/artifactregistry.reader"
  member = "serviceAccount:${module.gke.service_account}"
}