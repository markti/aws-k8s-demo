locals {
  cluster_subnet_ids = [for subnet in values(aws_subnet.backend) : subnet.id]
}

resource "aws_eks_cluster" "main" {
  name     = "eks-${var.application_name}-${var.environment_name}"
  role_arn = aws_iam_role.container_cluster.arn

  vpc_config {
    subnet_ids = local.cluster_subnet_ids
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_controller_policy,
  ]
}
