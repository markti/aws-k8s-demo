resource "helm_release" "secrets_store_csi_driver" {
  name       = "ingress"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "csi-secrets-store"
  namespace  = "kube-system"

}
/*
resource "helm_release" "secrets_store_csi_driver" {
  name       = "ingress"
  repository = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
  chart      = "secrets-provider-aws"
  namespace  = "kube-system"

}
*/