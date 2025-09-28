# 02 - Resource Group Lifecycle (Azure CLI)

## Create
```bash
az group create \
  --name rg-demo-core \
  --location eastus \
  --tags env=dev owner=team-infra costCenter=1234
```

## Show
```bash
az group show -n rg-demo-core -o table
```

## List With Tag Filter
```bash
az group list --tag env=dev -o table
```

## Update Tags (merge)
```bash
az group update -n rg-demo-core --set tags.retention=30d
```

## Add/Delete Lock
```bash
az lock create --name do-not-delete --lock-type CanNotDelete --resource-group rg-demo-core
az lock list -g rg-demo-core -o table
az lock delete --name do-not-delete -g rg-demo-core
```

## Export Template (reverse engineer)
```bash
az group export --name rg-demo-core > rg-demo-core.json
```

## Delete (with confirm)
```bash
az group delete -n rg-demo-core --yes --no-wait
```

## Best Practices
- Always apply consistent tags for cost and lifecycle
- Use locks on shared foundational groups
- Keep resource group scoping logical (lifecycle aligned)
- Avoid giant RGs mixing prod/non-prod

## Validate
```bash
az group list --query "[?name=='rg-demo-core']" -o jsonc
```
