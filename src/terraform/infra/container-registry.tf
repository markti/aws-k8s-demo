resource "aws_ecr_repository" "main" {
  name                 = "ecr-${var.application_name}-${var.environment_name}"
  image_tag_mutability = "MUTABLE"

  tags = {
    application = var.application_name
    environment = var.environment_name
  }

}

resource "aws_ecr_repository" "frontend" {
  name                 = "fleetops-frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "backend" {
  name                 = "fleetops-backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}