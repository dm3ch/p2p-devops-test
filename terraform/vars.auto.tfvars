gcs_state_bucket_name = "p2p-org-task-terraform-state"
gcs_state_bucket_path = "terraform/state"

project_id = "earnest-reactor-416012"
region = "europe-west1"

cluster_name = "gke-cluster"
network_name = "gke-cluster"
subnetwork_name = "gke-cluster"
docker_repository_name = "docker-repository"

ip_range_pods = "192.168.0.0/16"
ip_range_services = "10.96.0.0/12"
ip_range_nodes = "10.32.0.0/20"

argocd_chart_version = "6.6.0"
argocd_apps_chart_version = "1.6.2"

argocd_repository_url = "git@github.com:dm3ch/p2p-devops-test.git"
argocd_repository = "dm3ch/p2p-devops-test"

argocd_applications_definition = <<EOF
- name: apps
  namespace: argocd
  project: default
  source:
    repoURL: 'git@github.com:dm3ch/p2p-devops-test.git'
    path: argocd/apps
    targetRevision: master
  destination:
    server: https://kubernetes.default.svc
    namespace: argocd
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
EOF
