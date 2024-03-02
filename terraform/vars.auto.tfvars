gcs_state_bucket_name = "p2p-org-task-terraform-state"
gcs_state_bucket_path = "terraform/state"

project_id = "earnest-reactor-416012"
region = "europe-west1"

cluster_name = "gke-cluster"
network_name = "gke-cluster"
subnetwork_name = "gke-cluster"

ip_range_pods = "192.168.0.0/16"
ip_range_services = "10.96.0.0/12"
ip_range_nodes = "10.32.0.0/20"