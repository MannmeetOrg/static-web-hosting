
# AWS S3 Static Website Hosting using Terraform & Ansible

## Overview

This project automates the creation of an AWS S3 bucket configured for static website hosting using Terraform. It also uploads website files (`index.html` and `error.html`) using Ansible. A GitHub Actions workflow implements CI/CD to automatically provision infrastructure and upload website content upon each push to the `main` branch.

## Features

- Creates an S3 bucket with static website hosting enabled
- Public read access configured via bucket policy
- Website files uploaded using Ansible
- Terraform state stored remotely in S3 with DynamoDB locking
- IAM roles with scoped permissions for Terraform state management
- GitHub Actions for CI/CD automation

## Prerequisites

- AWS Account with proper IAM credentials
- Terraform installed locally (or use GitHub Actions)
- Ansible installed locally for manual uploads (optional)
- AWS CLI configured (recommended)
- Python and pip installed (for Ansible dependencies)
- GitHub Secrets configured for AWS credentials and bucket name:
    - `AWS_ACCESS_KEY_ID`
    - `AWS_SECRET_ACCESS_KEY`
    - `AWS_REGION`
    - `STATIC_WEBSITE_BUCKET_NAME`
    - `TERRAFORM_STATE_BUCKET_NAME` (used inside Terraform variables)
    - `TERRAFORM_LOCK_TABLE` (used inside Terraform variables)

# Project Directory Structure:
...
.
terraform-aws-s3-static-website/
├── ansible/
│   ├── inventory.ini
│   └── upload_website.yml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── iam.tf
│   ├── s3_bucket.tf
│   ├── backend.tf
│   ├── provider.tf
│   └── versions.tf
├── website/
│   ├── index.html
│   └── error.html
├── .github/
│   └── workflows/
│       └── terraform.yml
└── README.md
...

## Usage

### Terraform setup

1. Initialize Terraform backend (make sure state bucket and DynamoDB table exist).
2. Customize `terraform/variables.tf` or pass variables as CLI args.
3. Run:
   ```bash
   cd terraform
   terraform init
   terraform apply -auto-approve