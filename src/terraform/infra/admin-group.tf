resource "aws_iam_group" "admin" {
  name = "${var.application_name}-${var.environment_name}-admin"
}

data "aws_iam_policy_document" "admin" {
  statement {
    effect = "Allow"

    actions = [
      "eks:ListFargateProfiles",
      "eks:DescribeNodegroup",
      "eks:ListNodegroups",
      "eks:ListUpdates",
      "eks:AccessKubernetesApi",
      "eks:ListAddons",
      "eks:DescribeCluster",
      "eks:DescribeAddonVersions",
      "eks:ListClusters",
      "eks:ListIdentityProviderConfigs",
      "iam:ListRoles",
      "ssm:GetParameter"
    ]

    resources = ["*"]
  }

}

resource "aws_iam_policy" "admin" {
  name        = "${var.application_name}-${var.environment_name}-admin"
  description = "Policy to allow specific EKS and SSM access"
  policy      = data.aws_iam_policy_document.admin.json
}

resource "aws_iam_group_policy_attachment" "admin" {
  group      = aws_iam_group.admin.name
  policy_arn = aws_iam_policy.admin.arn
}

resource "aws_iam_group_membership" "admin" {
  name  = "${var.application_name}-${var.environment_name}-admin"
  users = var.admin_users
  group = aws_iam_group.admin.name
}