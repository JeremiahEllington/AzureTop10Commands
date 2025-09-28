# 03 - Storage Account Provision + SAS (Azure CLI)

```bash
SA_NAME=st${RANDOM}demo$RANDOM | tr -dc 'a-z0-9' | head -c 18
LOCATION=eastus
RG=rg-demo-core

az storage account create \
  --name $SA_NAME \
  --resource-group $RG \
  --location $LOCATION \
  --sku Standard_LRS \
  --kind StorageV2 \
  --https-only true \
  --min-tls-version TLS1_2 \
  --allow-blob-public-access false \
  --default-action Deny \
  --allow-shared-key-access false \
  --tags env=dev dataClass=general

# Add network rule (allow current public IP)
MY_IP=$(curl -s ifconfig.me)
az storage account network-rule add -g $RG --account-name $SA_NAME --ip-address $MY_IP

# Create container
az storage container create --account-name $SA_NAME --name demo --auth-mode login

# Upload file (uses Azure AD if RBAC granted)
az storage blob upload --account-name $SA_NAME -c demo -f ./sample.txt -n sample.txt --auth-mode login

# Generate short-lived SAS (container level, read only)
EXP=$(date -u -d "+1 hour" '+%Y-%m-%dT%H:%MZ')
az storage container generate-sas \
  --account-name $SA_NAME \
  --name demo \
  --expiry $EXP \
  --permissions r \
  --auth-mode login \
  --as-user
```

## Best Practices
- Disable shared key auth -> enforce AAD/RBAC
- Use private endpoints for production
- Restrict SAS with short expiry + least privilege
- Tag classification: `dataClass`, `owner`, `retention`
