# Install
- Install GKE cluster and GCR repo using TF IaaC from `terraform` directory
- Generate SSH keypair for ArgoCD usage
  ```bash
    ssh-keygen
  ```
- Add public part of generated key as a Deploy key to github repositoy (with RO permissions)
- Create k8s secret with generated secret:
  ```bash
    kubectl -n argocd create secret generic github-creds --from-file=sshPrivateKey=<path_to_private_key>
    kubectl -n argocd label secret github-creds "argocd.argoproj.io/secret-type=repo-creds"
  ```