variable "gcs_state_bucket_name" {
  description = "The name of GCS bucket used to store terraform state."
}

variable "gcs_state_bucket_path" {
  description = "The path in GCS bucket used to store terraform state."
}

variable "cluster_name" {
  description = "The cluster name"
}

variable "network_name" {
  description = "The network name"
}

variable "subnetwork_name" {
  description = "The network name"
}

variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "region" {
  description = "The region to host the cluster in"
}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
}

variable "ip_range_services" {
  description = "The secondary ip range to use for services"
}

variable "ip_range_nodes" {
  description = "The subnetwork ip range to use for nodes"
}

variable "argocd_version" {
    description = "Version of Argo CD to install"
}