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
variable "web_app_image" {
  type = object({
    name    = string
    version = string
  })
}
variable "alb_controller_role" {
  type = string
}