terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "shared_infra" {
  source = "../shared/terraform"

  environment = "uat"
  key_name    = "digital-kudos-wall-uat" # FIXME: Replace with your actual EC2 key pair name for ap-south-1
  aws_region  = "ap-south-1"          // Set the AWS region to Mumbai

  // You can override other variables from the shared module here if needed:
  instance_type = "t2.micro"            // Explicitly set to smallest free tier type
   frontend_port = 3000
   backend_port  = 3001 
   frontend_image = "ghcr.io/chirag1507/digital-kudos-wall-frontend:latest" // e.g., ghcr.io/youruser/frontend:latest
   backend_image  = "ghcr.io/chirag1507/digital-kudos-wall-backend:latest" // e.g., ghcr.io/youruser/backend:latest
   allowed_cidr_blocks = ["0.0.0.0/0"] # Keep open for now for simplicity, restrict in production
}

output "uat_frontend_url" {
  description = "URL for the UAT frontend"
  value       = module.shared_infra.frontend_url
}

output "uat_backend_url" {
  description = "URL for the UAT backend/microservice"
  value       = module.shared_infra.backend_url
}

output "uat_instance_public_ip" {
  description = "Public IP of the UAT EC2 instance"
  value       = module.shared_infra.instance_public_ip
}

output "uat_ssh_command" {
  description = "SSH command to connect to the UAT EC2 instance"
  value       = module.shared_infra.ssh_command
}

output "uat_instance_id" {
  description = "ID of the UAT EC2 instance"
  value       = module.shared_infra.instance_id
} 