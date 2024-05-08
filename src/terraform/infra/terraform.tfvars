application_name  = "fleet-portal"
environment_name  = "dev"
primary_region    = "us-west-2"
ecr_image_pushers = ["Terraform"]
vpc_cidr_block    = "10.0.0.0/21"
az_count          = 3
node_image_type   = "AL2_x86_64"
node_size         = "t3.medium"