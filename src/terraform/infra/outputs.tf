output "frontend_repository_url" {
  value = aws_ecr_repository.main["frontend"].repository_url
}
output "backend_repository_url" {
  value = aws_ecr_repository.main["backend"].repository_url
}