
locals {
  web_api_name = "fleet-api"
}

resource "kubernetes_deployment" "web_api" {
  metadata {
    name      = local.web_api_name
    namespace = var.namespace
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = local.web_api_name
      }
    }

    template {
      metadata {
        labels = {
          app = local.web_api_name
        }
      }

      spec {
        container {
          image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.primary_region}.amazonaws.com/${var.web_api_image.name}:${var.web_api_image.version}"
          name  = local.web_api_name
          port {
            container_port = 5000
          }
          env_from {
            config_map_ref {
              name = kubernetes_config_map.web_api.metadata.0.name
            }
          }
        }
      }
    }
  }

  timeouts {
    create = "5m"
    update = "5m"
    delete = "5m"
  }
}

resource "kubernetes_service" "web_api" {
  metadata {
    name      = "${local.web_api_name}-service"
    namespace = var.namespace

  }
  spec {
    type = "ClusterIP"
    port {
      port        = 80
      target_port = 5000
    }
    selector = {
      app = local.web_api_name
    }
  }
}

resource "kubernetes_config_map" "web_api" {
  metadata {
    name      = "${local.web_api_name}-config"
    namespace = var.namespace
  }

  data = {
    BackendEndpoint = ""
  }
}