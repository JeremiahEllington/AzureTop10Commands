# 02 - Resource Group Lifecycle (PowerShell Az)

```powershell
New-AzResourceGroup -Name rg-demo-core -Location eastus -Tag @{ env='dev'; owner='team-infra'; costCenter='1234' }

Get-AzResourceGroup -Name rg-demo-core | Format-List

Get-AzResourceGroup -Tag @{ env='dev' }

# Update tags (merge pattern)
Set-AzResourceGroup -Name rg-demo-core -Tag @{ env='dev'; owner='team-infra'; costCenter='1234'; retention='30d' }

# Locks
New-AzResourceLock -LockName do-not-delete -LockLevel CanNotDelete -ResourceGroupName rg-demo-core
Get-AzResourceLock -ResourceGroupName rg-demo-core
Remove-AzResourceLock -LockName do-not-delete -ResourceGroupName rg-demo-core -Force

# Delete
Remove-AzResourceGroup -Name rg-demo-core -Force -AsJob
```

## Best Practices
- Keep naming aligned to pattern `rg-<app>-<tier>`
- Scope policy assignments to RG for granularity
- Use tag governance (Policy) not manual enforcement
