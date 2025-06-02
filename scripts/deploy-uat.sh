#!/bin/bash

# Deploy to UAT Environment
set -e

echo "🚀 Deploying to UAT Environment..."

# Navigate to UAT terraform directory
cd "$(dirname "$0")/../environments/uat/terraform"

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
echo "🌐 UAT Environment is ready!"
echo "Access your application at the URL shown above." 