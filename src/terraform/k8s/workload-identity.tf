resource "kubernetes_service_account" "service_account" {
  metadata {
    name      = var.k8s_service_account_name
    namespace = var.k8s_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = var.workload_identity_role
    }
  }
}