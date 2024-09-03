provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "go_apps" {
  metadata {
    name = "go-apps"
  }
}

resource "kubernetes_deployment" "redis_backend" {
  metadata {
    name      = "redis-backend"
    namespace = kubernetes_namespace.go_apps.metadata[0].name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "redis-backend"
      }
    }
    template {
      metadata {
        labels = {
          app = "redis-backend"
        }
      }
      spec {
        container {
          name  = "redis-backend"
          image = "your-dockerhub-username/redis-backend:latest"
          port {
            container_port = 8081
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "redis_backend" {
  metadata {
    name      = "redis-backend"
    namespace = kubernetes_namespace.go_apps.metadata[0].name
  }
  spec {
    selector = {
      app = "redis-backend"
    }
    port {
      port        = 8081
      target_port = 8081
      protocol    = "TCP"
    }
    type = "ClusterIP"
  }
}
