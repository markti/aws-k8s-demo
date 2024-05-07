resource "aws_ecr_repository" "frontend" {
  name                 = "ecr-${var.application_name}-${var.environment_name}-frontend"
  image_tag_mutability = "MUTABLE"

  tags = {
    application = var.application_name
    environment = var.environment_name
  }

}

resource "aws_ecr_repository" "backend" {
  name                 = "ecr-${var.application_name}-${var.environment_name}-backend"
  image_tag_mutability = "MUTABLE"

  tags = {
    application = var.application_name
    environment = var.environment_name
  }

}