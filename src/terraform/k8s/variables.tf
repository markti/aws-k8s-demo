variable "registry_endpoint" {
  description = "The endpoint of the container registry"
  type        = string
}
variable "application_name" {
  type = string
}
variable "environment_name" {
  type = string
}
variable "cluster_name" {
  type = string
}
variable "primary_region" {
  type = string
}
variable "namespace" {
  type = string
}
variable "web_app_image" {
  type = object({
    name    = string
    version = string
  })
}
variable "web_api_image" {
  type = object({
    name    = string
    version = string
  })
}
variable "backend_endpoint" {
  type = string
}