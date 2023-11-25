output "registry_endpoint" {
  value = aws_ecr_repository.main.repository_url
}