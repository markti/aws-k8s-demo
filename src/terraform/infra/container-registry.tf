resource "aws_ecr_repository" "main" {
  name                 = "ecr-${var.application_name}-${var.environment_name}"
  image_tag_mutability = "MUTABLE"

  tags = {
    application = var.application_name
    environment = var.environment_name
  }

}