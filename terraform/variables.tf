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

variable "docker_repository_name" {
  description = "The name of artifacts repository containing docker images"
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

variable "argocd_chart_version" {
    description = "Version of Argo CD chart to install"
}

variable "argocd_apps_chart_version" {
    description = "Version of ArgoCD-Apps chart to install"
}

variable "argocd_repository_url" {
    description = "Repository that would be used by ArgoCD as a source in SSH format"
}

variable "argocd_repository" {
    description = "Repository that would be used by ArgoCD in github org/repo_name format, would be used in OIDC claims"
}

variable "argocd_private_key" {
    description = "SSH key that would be used by ArgoCD to access source repository"
}

variable "argocd_applications_definition" {
    description = "ArgoCD applications deffinition"
}
