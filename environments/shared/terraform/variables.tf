variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "digital-kudos-wall"
}

variable "environment" {
  description = "Environment name (uat, production)"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type (free tier)"
  type        = string
  default     = "t2.micro"
}

variable "frontend_port" {
  description = "Port for frontend application"
  type        = number
  default     = 3000
}

variable "backend_port" {
  description = "Port for backend application"
  type        = number
  default     = 3001
}

variable "frontend_image" {
  description = "Frontend Docker image"
  type        = string
  default     = "ghcr.io/chirag1507/digital-kudos-wall-frontend:latest"
}

variable "backend_image" {
  description = "Backend Docker image"
  type        = string
  default     = "ghcr.io/chirag1507/digital-kudos-wall-backend:latest"
}

variable "key_name" {
  description = "AWS Key Pair name for EC2 access"
  type        = string
  default     = ""
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the application"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # For learning - restrict this in real scenarios
} 