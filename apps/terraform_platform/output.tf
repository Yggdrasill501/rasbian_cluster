output "argocd_server_url" {
  value       = module.argocd.argocd_server_url
  description = "The URL to access the ArgoCD server"
}

output "argocd_initial_admin_password" {
  value       = module.argocd.argocd_initial_admin_password
  description = "The initial admin password for ArgoCD"
}

output "prometheus_server_url" {
  value       = module.prometheus_grafana.prometheus_server_url
  description = "The URL to access the Prometheus server"
}

output "grafana_server_url" {
  value       = module.prometheus_grafana.grafana_server_url
  description = "The URL to access the Grafana server"
}

output "grafana_admin_password" {
  value       = module.prometheus_grafana.grafana_admin_password
  description = "The admin password for Grafana"
}
