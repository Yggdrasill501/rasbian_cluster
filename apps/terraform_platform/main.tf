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

resource "kubernetes_deployment" "counter_backend" {
  metadata {
    name      = "counter-backend"
    namespace = kubernetes_namespace.go_apps.metadata[0].name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "counter-backend"
      }
    }
    template {
      metadata {
        labels = {
          app = "counter-backend"
        }
      }
      spec {
        container {
          name  = "counter-backend"
          image = "your-dockerhub-username/counter-backend:latest"
          port {
            container_port = 8080
          }
          env {
            name  = "REDIS_BACKEND_URL"
            value = "http://redis-backend.go-apps.svc.cluster.local:8081"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "counter_backend" {
  metadata {
    name      = "counter-backend"
    namespace = kubernetes_namespace.go_apps.metadata[0].name
  }
  spec {
    selector = {
      app = "counter-backend"
    }
    port {
      port        = 8080
      target_port = 8080
      protocol    = "TCP"
    }
    type = "NodePort"
  }
}
