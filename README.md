# Sentinel-Lab-IaC

This repository is a starter blueprint to build a cloud-first SOC lab in Azure with Microsoft Sentinel as SIEM/SOAR/TIP. It uses Terraform for core infra, Bicep for Sentinel resources, PowerShell for runtime/configuration and sample data ingestion, and GitHub Actions for CI/CD.


```Sentinel-Lab-Iac/
├── terraform/                  # Terraform files for core infrastructure
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── modules/
│   │   ├── resource_group/
│   │   ├── log_analytics/
│   │   └── sentinel/
├── bicep/                     # Bicep files for Sentinel content
│   ├── main.bicep
│   ├── analytics_rules/
│   ├── workbooks/
│   ├── watchlists/
│   └── playbooks/
├── scripts/                   # PowerShell scripts for API-based tasks
│   ├── deploy_content_hub.ps1
│   ├── configure_notebooks.ps1
├── .github/workflows/         # CI/CD pipelines
│   ├── deploy-terraform.yml
│   ├── deploy-bicep.yml
│   └── validate-code.yml
├── tests/                     # Unit tests for Terraform and Bicep
│   ├── terraform/
│   └── bicep/
└── README.md
```

## Prerequisites
- Azure Subscription with Owner/Contributor permissions.
- Terraform, Azure CLI, PowerShell installed.
- GitHub repository secrets: AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, AZURE_SUBSCRIPTION_ID, AZURE_TENANT_ID (create via `az ad sp create-for-rbac`).
- Variables: Set RESOURCE_GROUP_NAME and WORKSPACE_NAME in GitHub vars.

## Setup Instructions
1. Clone the repo: `git clone <repo-url>`.
2. Initialize Terraform: `cd terraform; terraform init`.
3. Deploy infrastructure: `terraform apply`.
4. Deploy Bicep content: `az deployment group create --resource-group sentinel-training-rg --template-file bicep/main.bicep --parameters workspaceName=sentinel-training-workspace`.
5. Run PowerShell scripts: `pwsh scripts/deploy_content_hub.ps1` (for Training Lab fallback) and `pwsh scripts/configure_notebooks.ps1`.
6. Authorize Playbook: In Azure Portal, go to Logic Apps > Get-GeoFromIpAndTagIncident > Authorize.
7. Verify: In Sentinel > Content Hub, confirm Training Lab installed. Check incidents, rules, etc.

## Usage
- Push changes to `main` to trigger CI/CD.
- Play around: Use generated incidents for training (e.g., investigate "Solorigate Network Beacon").

## Components
- Infrastructure: Resource group, Log Analytics, Sentinel.
- Training Lab: Pre-recorded data, rules, queries, workbook, playbook.
- Custom: Sample rule, workbook, watchlist, notebook.

Use Git branches (e.g., main, dev, feature/*) for development and testing.
Enable branch protection on main to require pull request reviews and passing CI/CD checks.


