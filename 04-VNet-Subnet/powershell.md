# 04 - Virtual Network + Subnet (PowerShell Az)

```powershell
$rg = 'rg-demo-core'
$loc = 'eastus'
$vnet = 'vnet-demo-core'

$subnetApp = New-AzVirtualNetworkSubnetConfig -Name 'snet-app' -AddressPrefix '10.10.1.0/24'
$subnetData = New-AzVirtualNetworkSubnetConfig -Name 'snet-data' -AddressPrefix '10.10.2.0/24'

New-AzVirtualNetwork -Name $vnet -ResourceGroupName $rg -Location $loc -AddressPrefix '10.10.0.0/16' -Subnet $subnetApp,$subnetData

Get-AzVirtualNetwork -Name $vnet -ResourceGroupName $rg | Select -ExpandProperty subnets | Format-Table Name,AddressPrefix
```