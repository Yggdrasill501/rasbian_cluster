variable "argocd_version" {
  description = "Version of the ArgoCD Helm chart"
  type        = string
  default     = "5.19.3"
}

variable "prometheus_version" {
  description = "Version of the Prometheus Helm chart"
  type        = string
  default     = "15.0.0"
}

variable "grafana_version" {
  description = "Version of the Grafana Helm chart"
  type        = string
  default     = "6.57.4"
}

variable "argocd_node_port" {
  description = "NodePort for ArgoCD"
  type        = number
  default     = 30080
}

variable "prometheus_node_port" {
  description = "NodePort for Prometheus"
  type        = number
  default     = 30090
}

variable "grafana_node_port" {
  description = "NodePort for Grafana"
  type        = number
  default     = 30180
}
