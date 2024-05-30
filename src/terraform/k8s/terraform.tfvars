application_name = "fleet-app"
environment_name = "dev"
namespace        = "app"
web_app_image = {
  name    = "ecr-fleet-portal-dev-frontend"
  version = "2024.05.14"
}
web_api_image = {
  name    = "ecr-fleet-portal-dev-backend"
  version = "2024.05.2"
}