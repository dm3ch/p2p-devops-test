# Tradeoffs
- Terraform instead of Crossplane - cause I have very limited amount of free time.
- Terraform single module instead of separation to reusable modules - cause in this test there's no need to reuse anything and to not to introduce additional instruments like terragrunt.
- Manual creation of ArgoCD ssh secret - to not to expose ssh key in this repo or in TF state. But I have no time to research if it's possible to make ArgoCD access Github without static secret (maybe it's possible to implement using Hashicorp Vault).
- Manifests for test-app is a Helm chart - cause I was limited by time and decided to not to research other template engines that is new to me.
- Expose app using LB insted of Ingress - to not to register domain name for testing.
- Additional apps / ns are just placeholders - cause I have no need in additional infra components, but have to add anything to meet criterias from task.
- Documentation doesn't exist at all :D - cause task text don't asks for it and cause I was in a hurry.

# How to install - highlevel
- Install GKE cluster and GCR repo using TF IaaC from `terraform` directory
- Generate SSH keypair for ArgoCD usage
  ```bash
    ssh-keygen
  ```
- Add public part of generated key as a Deploy key to github repositoy (with RO permissions)
- Create k8s secret with generated secret:
  ```bash
    kubectl -n argocd create secret generic github-creds --from-file=sshPrivateKey=<path_to_private_key> --from-literal=url=git@github.com:dm3ch/p2p-devops-test.git
    kubectl -n argocd label secret github-creds "argocd.argoproj.io/secret-type=repo-creds"
  ```