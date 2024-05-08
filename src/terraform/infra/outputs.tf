output "frontend_repository" {
  value = aws_ecr_repository.main["frontend"].name
}
output "frontend_repository_url" {
  value = aws_ecr_repository.main["frontend"].repository_url
}
output "backend_repository" {
  value = aws_ecr_repository.main["backend"].name
}
output "backend_repository_url" {
  value = aws_ecr_repository.main["backend"].repository_url
}
output "kubernetes_cluster_name" {
  value = aws_eks_cluster.main.name
}