
locals {
  web_app_name = "fleet-portal"
}

resource "kubernetes_deployment" "web_app" {
  metadata {
    name      = local.web_app_name
    namespace = var.namespace
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = local.web_app_name
      }
    }

    template {
      metadata {
        labels = {
          app = local.web_app_name
        }
      }

      spec {
        container {
          image = "${var.web_app_image.name}:${var.web_app_image.version}"
          name  = local.web_app_name
          port {
            container_port = 5000
          }
          env_from {
            config_map_ref {
              name = kubernetes_config_map.web_app.metadata.0.name
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "web_app" {
  metadata {
    name      = "${local.web_app_name}-service"
    namespace = var.namespace
  }
  spec {
    type = "LoadBalancer"
    port {
      port        = 80
      target_port = 5000
    }
    selector = {
      app = local.web_app_name
    }
  }
}

resource "kubernetes_config_map" "web_app" {
  metadata {
    name      = "${local.web_app_name}-config"
    namespace = var.namespace
  }

  data = {
    BackendEndpoint = ""
  }
}

resource "kubernetes_ingress_v1" "web_app" {
  metadata {
    name      = "web_app"
    namespace = var.namespace
    annotations = {
      "kubernetes.io/ingress.class"            = "alb"
      "alb.ingress.kubernetes.io/scheme"       = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"  = "ip"
      "alb.ingress.kubernetes.io/listen-ports" = jsonencode([{ "HTTP" : 80 }])
    }
  }
  spec {
    rule {
      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.web_app.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}