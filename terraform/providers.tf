terraform {
  backend "gcs" {
    bucket = "p2p-org-task-terraform-state"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.18.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "default" {
  depends_on = [module.gke]
}

provider "helm" {
  kubernetes {
    host  = "https://${module.gke.endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  }
}
