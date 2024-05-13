data "aws_caller_identity" "current" {}

resource "aws_iam_role" "console_access" {

  name = "${var.application_name}-${var.environment_name}-console-access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action = "sts:AssumeRole"
      }
    ],
  })
}

resource "aws_iam_policy" "console_access" {
  name        = "${var.application_name}-${var.environment_name}-console-access"
  description = "Allow users to assume the role to access EKS from the console"

  policy = data.aws_iam_policy_document.console_access.json
}

data "aws_iam_policy_document" "console_access" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.console_access.arn]
  }
}

resource "aws_iam_group_policy_attachment" "console_access" {
  group      = aws_iam_group.admin.name
  policy_arn = aws_iam_policy.console_access.arn
}