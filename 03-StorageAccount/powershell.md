# 03 - Storage Account (PowerShell Az)

```powershell
$rg = 'rg-demo-core'
$loc = 'eastus'
$sa = ('st' + (New-Guid).Guid.Replace('-', '').Substring(0,18)).ToLower()

New-AzStorageAccount -Name $sa -ResourceGroupName $rg -Location $loc -SkuName Standard_LRS -Kind StorageV2 -EnableHttpsTrafficOnly $true -AllowBlobPublicAccess $false -MinimumTlsVersion TLS1_2 -AllowSharedKeyAccess $false -Tag @{ env='dev'; owner='team-infra'; dataClass='general' }

# Create container (requires role: Storage Blob Data Contributor)
$ctx = (Get-AzStorageAccount -Name $sa -ResourceGroupName $rg).Context
New-AzStorageContainer -Name 'demo' -Context $ctx -Permission Off

# Upload blob via Az.Storage (AAD auth under current context)
Set-AzStorageBlobContent -File ./sample.txt -Container 'demo' -Blob 'sample.txt' -Context $ctx
```
