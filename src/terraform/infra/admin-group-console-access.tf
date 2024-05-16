data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "console_access" {
  version = "2012-10-17"

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
      "iam:ListRoles"
    ]
    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameter"]
    resources = ["arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:parameter/*"]
  }
}

resource "aws_iam_policy" "console_access" {

  name        = "${var.application_name}-${var.environment_name}-console-access"
  description = "Allow users to assume the role to access EKS from the console"
  policy      = data.aws_iam_policy_document.console_access.json

}

data "aws_iam_policy_document" "console_access_assume_role_policy" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"] # Allow all users
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "console_access" {
  name               = "${var.application_name}-${var.environment_name}-console-access"
  assume_role_policy = data.aws_iam_policy_document.console_access_assume_role_policy.json
}