resource "aws_iam_policy" "console_access" {
  name        = "AssumeExampleRole"
  description = "Allows assuming the specified EKS role"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = "sts:AssumeRole",
      Resource = "${aws_iam_role.console_access.arn}"
    }]
  })
}

resource "aws_iam_role" "console_access" {
  name               = "${var.application_name}-${var.environment_name}-console-access"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_group_policy_attachment" "console_access" {
  group      = aws_iam_group.admin.name
  policy_arn = aws_iam_policy.console_access.arn
}