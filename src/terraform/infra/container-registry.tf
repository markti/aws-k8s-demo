locals {
  repository_list = ["frontend", "backend"]
  repositories    = { for name, name in local.repository_list : name => name }
}

resource "aws_ecr_repository" "main" {

  for_each = local.repositories

  name                 = "ecr-${var.application_name}-${var.environment_name}-${each.key}"
  image_tag_mutability = "MUTABLE"

  tags = {
    application = var.application_name
    environment = var.environment_name
  }

}