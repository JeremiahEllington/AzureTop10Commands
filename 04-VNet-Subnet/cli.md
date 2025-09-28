# 04 - Virtual Network + Subnet (Azure CLI)

```bash
RG=rg-demo-core
VNET=vnet-demo-core
LOCATION=eastus

az network vnet create \
  --resource-group $RG \
  --name $VNET \
  --address-prefixes 10.10.0.0/16 \
  --subnet-name snet-app \
  --subnet-prefix 10.10.1.0/24

# Add additional subnet
az network vnet subnet create \
  --resource-group $RG \
  --vnet-name $VNET \
  --name snet-data \
  --address-prefixes 10.10.2.0/24

# List subnets
az network vnet subnet list -g $RG --vnet-name $VNET -o table
```

## Best Practices
- Reserve lower subnets for infra, upper for apps
- Plan address space with future peering in mind
- Use Network Security Groups per subnet where required
