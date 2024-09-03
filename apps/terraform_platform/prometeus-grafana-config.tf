resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "15.0.0"

  values = [
    <<EOF
alertmanager:
  enabled: false

pushgateway:
  enabled: false

server:
  persistentVolume:
    enabled: false
  service:
    type: NodePort
    nodePort: 30090
EOF
  ]
}

resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "6.57.4"

  values = [
    <<EOF
service:
  type: NodePort
  nodePort: 30180
persistence:
  enabled: false
adminPassword: "admin" # change this in production
EOF
  ]
}

output "prometheus_server_url" {
  value = "http://${kubernetes_namespace.monitoring.metadata[0].name}.local:30090"
}

output "grafana_server_url" {
  value = "http://${kubernetes_namespace.monitoring.metadata[0].name}.local:30180"
}

output "grafana_admin_password" {
  value       = helm_release.grafana.values["adminPassword"]
  description = "The admin password for Grafana"
}
