# 02 - Resource Group Cleanup

## Delete Group
```bash
az group delete -n rg-demo-core --yes --no-wait
```

## Confirm Deletion
```bash
az group list --query "[?name=='rg-demo-core']" -o tsv
```

## Remove Orphaned Locks (if any remain)
```bash
az lock list --query "[?resourceGroup=='rg-demo-core']" -o table
```
