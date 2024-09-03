provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.19.3"

  values = [
    <<EOF
server:
  service:
    type: NodePort
    nodePort: 30080
  ingress:
    enabled: false
  config:
    url: http://argocd.local

dex:
  enabled: false
EOF
  ]
}

output "argocd_server_url" {
  value = "http://${kubernetes_namespace.argocd.metadata[0].name}.local:30080"
}

output "argocd_initial_admin_password" {
  value = kubernetes_secret.argocd_server.metadata[0].name
  description = "The initial admin password for ArgoCD"
}

resource "kubernetes_secret" "argocd_server" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }

  data = {
    password = "dXNlci1wYXNzd29yZAo=" # base64 encoded "user-password"
  }
}
