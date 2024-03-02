resource "google_iam_workload_identity_pool" "identity-pool" {
  workload_identity_pool_id = "github-actions"
}

resource "google_iam_workload_identity_pool_provider" "github-oidc-provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.identity-pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-actions"
  attribute_mapping = {
    "google.subject" = "assertion.sub",
    "attribute.actor" = "assertion.actor",
    "attribute.repository" = "assertion.repository",
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  attribute_condition = "attribute.repository==\"${var.argocd_repository}\""
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account" "github-actions" {
  account_id   = "github-actions"
  display_name = "Github Actions"
}

resource "google_artifact_registry_repository_iam_member" "github-actions-docker-image-write" {
  location      = var.region
  repository = google_artifact_registry_repository.docker_repository.id
  role = "roles/artifactregistry.writer"
  member = "serviceAccount:${google_service_account.github-actions.email}"
}

resource "google_service_account_iam_binding" "github-actions" {
  service_account_id = google_service_account.github-actions.id
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.identity-pool.name}/attribute.repository/${var.argocd_repository}",
  ]
}

resource "google_project_iam_member" "test" {
  project = var.project_id
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${google_service_account.github-actions.email}"
}