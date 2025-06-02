# Digital Kudos Wall - Infrastructure

Infrastructure as Code for Digital Kudos Wall AWS environments.

## Overview

This repository contains the infrastructure setup for deploying the Digital Kudos Wall system to AWS. It supports multiple environments following the Release Stage pipeline approach.

## Environments

- **UAT Environment** - For QA Engineers to perform manual testing
- **Production Environment** - For end users

## Architecture

```
┌─────────────────┐    ┌─────────────────┐
│   UAT Environment   │    │ Production Environment │
├─────────────────┤    ├─────────────────┤
│ - ECS Cluster   │    │ - ECS Cluster   │
│ - Load Balancer │    │ - Load Balancer │
│ - RDS Database  │    │ - RDS Database  │
│ - CloudWatch    │    │ - CloudWatch    │
└─────────────────┘    └─────────────────┘
```

## Tech Stack

- **AWS ECS** - Container orchestration
- **AWS Application Load Balancer** - Load balancing and SSL termination
- **AWS RDS** - Managed database service
- **AWS CloudWatch** - Monitoring and logging
- **AWS ECR** - Container registry (GitHub Container Registry alternative)
- **Terraform** - Infrastructure as Code
- **Docker Compose** - Local development

## Project Structure

```
environments/
├── uat/                # UAT environment configuration
│   ├── terraform/      # Terraform files for UAT
│   └── docker-compose.yml
├── production/         # Production environment configuration
│   ├── terraform/      # Terraform files for Production
│   └── docker-compose.yml
├── shared/             # Shared infrastructure components
│   └── terraform/      # Common Terraform modules
└── scripts/            # Deployment and utility scripts
```

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform installed
- Docker and Docker Compose installed

## Quick Start

### 1. Configure AWS Credentials

```bash
aws configure
```

### 2. Deploy UAT Environment

```bash
cd environments/uat/terraform
terraform init
terraform plan
terraform apply
```

### 3. Deploy Production Environment

```bash
cd environments/production/terraform
terraform init
terraform plan
terraform apply
```

## Environment URLs

After deployment, the environments will be available at:

- **UAT**: `https://uat.digital-kudos-wall.your-domain.com`
- **Production**: `https://digital-kudos-wall.your-domain.com`

## Release Process

This infrastructure supports the Release Stage pipeline:

1. **Component Release Stages** - Deploy individual services (Frontend, Backend)
2. **System Release Stage** - Deploy complete system to target environment
3. **Environment Configuration** - Automated environment setup
4. **Smoke Tests** - Basic health checks after deployment

## Security

- **VPC** with private subnets for databases
- **Security Groups** with minimal required access
- **IAM Roles** with least privilege principle
- **SSL/TLS** termination at load balancer
- **Environment variable** encryption

## Monitoring

- **CloudWatch Logs** for application logs
- **CloudWatch Metrics** for system metrics
- **Health Checks** for service availability
- **Alarms** for critical issues

## Cost Optimization

- **Auto Scaling** based on demand
- **Spot Instances** for non-critical workloads
- **Resource Tagging** for cost tracking
- **Environment Scheduling** (UAT can be stopped outside business hours)

## Contributing

This infrastructure follows:

- **Infrastructure as Code** principles
- **Environment Parity** between UAT and Production
- **Automated Deployment** via CI/CD pipelines
- **Version Control** for all infrastructure changes

## Links

- [Main Project Repository](https://github.com/chirag1507/digital-kudos-wall)
- [Frontend Repository](https://github.com/chirag1507/digital-kudos-wall-frontend)
- [Backend Repository](https://github.com/chirag1507/digital-kudos-wall-backend)
- [System Tests Repository](https://github.com/chirag1507/digital-kudos-wall-system-tests)
