locals {
  argocd_values = {
    # Configure repository connection
    configs = {
      repositories = {
        github = {
          url = var.argocd_repository_url
        }
      }
    }

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
  version    = var.argocd_chart_version

  values = [yamlencode(local.argocd_values)]
}

resource "helm_release" "argocd-apps" {
  name             = "argocd-apps"
  namespace        = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  version    = var.argocd_apps_chart_version

  values = [yamlencode({
    applications = yamldecode(var.argocd_applications_definition)
  })]

  depends_on = [ helm_release.argocd ]
}