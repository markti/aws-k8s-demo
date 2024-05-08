output "frontend_repository" {
  value = aws_ecr_repository.main["frontend"].name
}
output "backend_repository" {
  value = aws_ecr_repository.main["backend"].name
}