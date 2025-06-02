#!/bin/bash

# Deploy to Production Environment
set -e

echo "🚀 Deploying to Production Environment..."

# Navigate to Production terraform directory
cd "$(dirname "$0")/../environments/production/terraform"

# Initialize Terraform
echo "📦 Initializing Terraform..."
terraform init

# Plan the deployment
echo "📋 Planning deployment..."
terraform plan -out=tfplan

# Apply the deployment
echo "🔧 Applying deployment..."
terraform apply tfplan

# Show outputs
echo "✅ Deployment complete! Environment details:"
terraform output

echo ""
echo "🌐 Production Environment is ready!"
echo "Access your application at the URL shown above." 