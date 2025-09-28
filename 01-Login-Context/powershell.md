# 01 - Login & Subscription Context (PowerShell Az)

## Module Prep
```powershell
# Install (if needed)
Install-Module Az -Scope CurrentUser -Repository PSGallery -Force

# Update
Update-Module Az
```

## Authentication
```powershell
# Interactive
auth = Connect-AzAccount

# Device code
Connect-AzAccount -UseDeviceAuthentication

# Specific tenant
Connect-AzAccount -Tenant <tenantId>

# Managed Identity (inside Azure)
Connect-AzAccount -Identity
```

## Subscription Context
```powershell
Get-AzSubscription | Format-Table Name, Id, State
Set-AzContext -Subscription <subIdOrName>
Get-AzContext
```

## Defaults Helper
```powershell
# Pseudo default pattern
$Location = "eastus"
$ResourceGroup = "rg-demo-core"
```

## Access Token (diagnostics)
```powershell
(Get-AzAccessToken -ResourceUrl 'https://management.azure.com').ExpiresOn
```

## Service Principal (CI/CD) - Prefer OIDC Instead
```powershell
# Legacy (avoid storing secrets)
$Cred = Get-Credential # AppId + Secret
Connect-AzAccount -ServicePrincipal -Credential $Cred -Tenant <tenantId>
```

## OIDC (GitHub Actions) Pattern
```powershell
# In workflow, AzureLogin action obtains token then context is set
# Subsequent Az cmdlets just work with that federated identity
```

## Troubleshooting
| Symptom | Action |
|---------|--------|
| MFA blocking automation | Implement workload identity federation |
| No subscriptions returned | Ensure account is added as RBAC IAM role |
| Random auth prompts | Update Az module & clear token cache |

## Security Notes
- Remove stale contexts: `Clear-AzContext -Force`
- Use `Connect-AzAccount -UseDeviceAuthentication` on jump boxes
