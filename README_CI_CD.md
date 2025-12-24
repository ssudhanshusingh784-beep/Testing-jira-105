CI/CD and Container Deployment (ACR → ACI)
=========================================

This repo contains example files to build a Docker image from repository contents, push it to Azure Container Registry (ACR), and deploy it to Azure Container Instances (ACI) using Terraform. A GitHub Actions workflow orchestrates the sequence:

- Terraform apply in `infra/acr` creates an ACR instance (admin enabled).
- GitHub Actions builds a Docker image (`Dockerfile` in repo root) and pushes it to the new ACR.
- Terraform apply in `infra/aci` deploys an ACI instance pulling the pushed image using registry credentials.

Required GitHub secrets
- `AZURE_CREDENTIALS` — service principal JSON used by `azure/login`. Create with `az ad sp create-for-rbac --sdk-auth --role Contributor` or a least-privilege role. Store the JSON in the secret.

How it works locally
1. Create or update `terraform.tfvars` or pass variables on the CLI for both folders.
2. Create ACR first (or let the workflow create it):
   - cd infra/acr
   - terraform init
   - terraform apply
3. Build and push the image (example):
   - docker build -t <acr-login-server>/<name>:<tag> .
   - docker login <acr-login-server> --username <user> --password <pass>
   - docker push <acr-login-server>/<name>:<tag>
4. Deploy ACI (after image is available):
   - cd infra/aci
   - terraform init
   - terraform apply -var "acr_login_server=<login>" -var "acr_username=<user>" -var "acr_password=<pass>" -var "image_tag=<tag>" -var "image_name=<name>"

Notes and best-practices
- For production use, avoid `admin_enabled = true` on ACR; instead, use a Managed Identity or service principal and grant `acrpull` role to the identity used by ACI/VM.
- Consider using Azure Kubernetes Service (AKS) or App Service for more advanced orchestration and scaling.
- Use remote state (Azure Storage backend) for Terraform in CI to avoid state drift.
