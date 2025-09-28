# Azure Top 10 Operational Command Guides

A curated, extensible repository of the 10 most essential day-to-day Azure operational command scenarios. Each topic includes:

- Azure CLI usage (idempotent patterns)
- PowerShell Az equivalent
- Bicep Infrastructure-as-Code snippet (where applicable)
- Automation notes (GitHub Actions / Azure DevOps hints)
- Security + RBAC least-privilege notes
- Troubleshooting + validation commands
- Clean-up / teardown guidance

## ✅ Covered Command Scenarios

| # | Scenario | Purpose | Core Services |
|---|----------|---------|---------------|
| 1 | Login & Subscription Context | Authenticate & set execution scope | Entra ID, ARM |
| 2 | Resource Group Lifecycle | Create, tag, lock, delete | Resource Manager |
| 3 | Storage Account Provision & SAS | Create secure storage + access delegation | Storage |
| 4 | Virtual Network + Subnet | Create network fabric | Network |
| 5 | Azure Container Registry + Image Push | Store container images | ACR, Identity |
| 6 | Azure Container Apps Minimal Deploy | Rapid app hosting | ACA, Log Analytics |
| 7 | Key Vault Secrets & RBAC | Secure secret management | Key Vault |
| 8 | Managed Identity + Access Grant | Identity-based auth | MSI, RBAC |
| 9 | Log Analytics Workspace + Query | Observability foundation | Monitor, Kusto |
| 10 | Cleanup & Governance Checks | Controlled teardown / audit | Policy, Resource Graph |

> Future additions: AKS baseline, Azure Functions, Bicep module registry, Cost optimization quick checks.

## 📁 Repository Structure
```
AzureTop10Commands/
├── README.md
├── 01-Login-Context/
│   ├── cli.md
│   ├── powershell.md
│   ├── troubleshooting.md
├── 02-ResourceGroups/
│   ├── cli.md
│   ├── bicep.bicep
│   ├── powershell.md
│   ├── cleanup.md
├── 03-StorageAccount/
│   ├── cli.md
│   ├── bicep.bicep
│   ├── powershell.md
│   ├── security.md
├── 04-VNet-Subnet/
│   ├── cli.md
│   ├── bicep.bicep
│   ├── powershell.md
├── 05-ACR-ImagePush/
│   ├── cli.md
│   ├── bicep.bicep
│   ├── powershell.md
├── 06-ContainerApp/
│   ├── cli.md
│   ├── bicep.bicep
│   ├── powershell.md
├── 07-KeyVault-Secrets/
│   ├── cli.md
│   ├── bicep.bicep
│   ├── powershell.md
│   ├── security.md
├── 08-ManagedIdentity-RBAC/
│   ├── cli.md
│   ├── bicep.bicep
│   ├── powershell.md
├── 09-LogAnalytics-Query/
│   ├── cli.md
│   ├── bicep.bicep
│   ├── powershell.md
│   ├── queries.kql
├── 10-Cleanup-Governance/
│   ├── cli.md
│   ├── powershell.md
│   ├── governance.md
└── _shared/
    ├── tags.md
    ├── rbac.md
    ├── naming-conventions.md
```

## 🔐 Authentication Guidance
Use Managed Identity where executing inside Azure (e.g., GitHub Actions OIDC + workload identity federation, Azure DevOps service connection). Avoid embedding secrets. For local dev prefer `az login` (device code if headless) or `Connect-AzAccount`.

## 🧪 Validation Pattern
Each scenario follows: Plan → Apply → Verify → Secure → Monitor → Clean.

## 🧰 Tooling Tips
- Use `az config set defaults.group=<rg> location=<loc>` to reduce repetition
- Use `--only-show-errors` in automation for cleaner logs
- Always add `--tags` for cost management and governance

## 🛡 Security & RBAC
Principle of least privilege: scope role assignments at the smallest necessary resource. Prefer built-in roles. Use Key Vault + managed identity instead of secrets.

## 🧹 Cleanup Discipline
All scenarios document reversible operations and teardown commands. Always verify no shared dependencies before deletion.

## 🗺 Roadmap
- Add GitHub Actions workflow samples
- Create Azure Policy baseline examples
- Add cost estimation notes (Pricing calculator references)
- Add Terraform equivalents (separate folder)

---
Maintainer: Jeremiah Ellington  
Last Updated: 2025-09-28
