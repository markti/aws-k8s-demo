variable "registry_endpoint" {
  type        = string
  description = "Provided by the GitHub Action"
}
variable "application_name" {
  type = string
}
variable "environment_name" {
  type = string
}
variable "cluster_name" {
  type        = string
  description = "Provided by the GitHub Action"
}
variable "primary_region" {
  type        = string
  description = "Provided by the GitHub Action"
}
variable "namespace" {
  type = string
}