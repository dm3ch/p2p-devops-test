locals {
  argocd_values = {
    # Configure repository connection
    configs = {
    #   credentialTemplates = {
    #     github-ssh = {
    #       url           = var.argocd_repository_url
    #       sshPrivateKey = var.argocd_private_key
    #     }
    #   }
    #   repositories = {
    #     github = {
    #       url = var.argocd_repository_url
    #     }
    #   }
    }

    # Configure initial applications list
    # server = {
    #   additionalApplications = yamldecode(var.argocd_applications_definition)
    # }

    # Configure rbac to enable application CRD sync
    repoServer = {
      rbac = [{
        apiGroups = ["argoproj.io"]
        resources = ["applications"]
        verbs     = ["get", "list", "watch"]
      }]
    }

    # Disable not used ArgoCD components
    notifications = {
      enabled = "false"
    }
    dex = {
      enabled = "false"
    }
    applicationSet = {
      enabled = "false"
    }
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_version

  values = [yamlencode(local.argocd_values)]
}