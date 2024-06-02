data "tls_certificate" "container_cluster_oidc" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "container_cluster_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.container_cluster_oidc.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.container_cluster_oidc.url
}

data "aws_iam_policy_document" "workload_identity" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.container_cluster_oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.k8s_namespace}:${var.k8s_service_account_name}"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.container_cluster_oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "workload_identity" {
  assume_role_policy = data.aws_iam_policy_document.workload_identity.json
  name               = "${var.application_name}-${var.environment_name}-workload-identity"
}

data "aws_iam_policy_document" "workload_identity_policy" {
  statement {
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "workload_identity" {

  name        = "${var.application_name}-${var.environment_name}-workload-identity"
  description = "Policy for ${var.application_name}-${var.environment_name} Workload Identity"
  policy      = data.aws_iam_policy_document.workload_identity_policy.json

}