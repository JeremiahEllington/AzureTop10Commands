# 01 - Login & Subscription Context (Azure CLI)

## Goal
Authenticate, select the correct subscription, set safe defaults, and prepare environment for idempotent operations.

## Commands
```bash
# Interactive login (browser)
az login

# Device code (headless / restricted env)
az login --use-device-code

# List subscriptions
az account list --output table

# Set active subscription
az account set --subscription <SUBSCRIPTION_ID_OR_NAME>

# Set default location and group (locally persisted)
az config set defaults.location=eastus defaults.group=rg-demo-core

# Verify context
az account show --output table

# Show current defaults
grep -i defaults ~/.azure/config 2> /dev/null || type az
```

## Managed Identity (inside Azure)
```bash
# Within Azure Cloud Shell or managed identity-enabled container/app
az login --identity
```

## Best Practices
- Use `az login --tenant <tenant_id>` in multi-tenant environments
- For automation use OIDC (GitHub Actions) or service principal with Federated Credentials
- Never embed client secrets in scripts—prefer workload identity federation
- Store ephemeral scripts outside production repo or mark as internal

## Clean Verification
```bash
az account get-access-token --resource https://management.azure.com --query expiresOn -o tsv
```

## Troubleshooting
| Issue | Command | Notes |
|-------|---------|-------|
| Stale token | `az account clear` | Clears cached tokens |
| Wrong tenant | `az login --tenant <id>` | Re-auth in correct directory |
| Missing subscription | `az account list --refresh` | Forces refresh |
| Permission denied | `az role assignment list --scope <scope>` | Confirm RBAC |

## Security Notes
- Use Conditional Access + MFA policies
- Restrict local persistence on shared build agents
- Audit sign-ins via Entra ID sign-in logs
