# Sentinel-Lab-IaC

This repository is a starter blueprint to build a cloud-first SOC lab in Azure with Microsoft Sentinel as SIEM/SOAR/TIP. It uses Terraform for core infra, Bicep for Sentinel resources, PowerShell for runtime/configuration and sample data ingestion, and GitHub Actions for CI/CD.


Sentinel-Lab-Iac/
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

Use Git branches (e.g., main, dev, feature/*) for development and testing.
Enable branch protection on main to require pull request reviews and passing CI/CD checks.
