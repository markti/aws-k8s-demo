resource "helm_release" "csi_secrets_store" {

  name       = "csi-secrets-store"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"
  namespace  = "kube-system"

}


resource "helm_release" "aws_secrets_provider" {

  name       = "secrets-provider-aws"
  repository = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
  chart      = "secrets-store-csi-driver-provider-aws"
  namespace  = "kube-system"

}

locals {
  secrets = {
    "${var.application_name}-${var.environment_name}-connection-string" = "DB_CONNECTION_STRING"
  }
}

resource "kubernetes_manifest" "secret_provider_class" {

  manifest = {
    apiVersion = "secrets-store.csi.x-k8s.io/v1"
    kind       = "SecretProviderClass"
    metadata = {
      name      = "${var.application_name}-${var.environment_name}-secret-provider-class"
      namespace = var.k8s_namespace
    }
    spec = {
      provider = "aws"
      parameters = {
        objects = jsonencode([
          for key, value in local.secrets : {
            objectName         = key
            objectType         = "secretsmanager"
            objectVersionLabel = "AWSCURRENT"
          }
        ])
      }
    }
  }

}