resource "aws_iam_policy" "console_access" {
  name        = "${var.application_name}-${var.environment_name}-console-access"
  description = "Allow users to assume the role to access EKS from the console"

  policy = aws_iam_policy_document.console_access.json
}

data "aws_iam_policy_document" "console_access" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = aws_iam_role.console_access.arn
  }
}

resource "aws_iam_group_policy_attachment" "console_access" {
  group      = aws_iam_group.admin.name
  policy_arn = aws_iam_policy.console_access.arn
}