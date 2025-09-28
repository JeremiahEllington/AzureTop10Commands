# 01 - Login Troubleshooting Deep Dive

## Common Failure Categories
1. Directory / tenant mismatch
2. Conditional Access enforcement
3. Expired or revoked service principal credentials
4. Local token cache corruption
5. Firewall / proxy interception

## Diagnostic Commands
```bash
# Show current token audiences (debug)
AZURE_CORE_ONLY_SHOW_ERRORS=1 az account get-access-token --resource https://management.azure.com | jq '.'

# HTTP tracing
AZURE_HTTP_LOGGING_ONLY_BODY=1 az group list --debug
```

## Reset State
```bash
rm -rf ~/.azure/*token* ~/.azure/azureProfile.json 2>/dev/null || echo 'Windows path cleanup manually'
```

## Entra ID Sign-In Log Correlation
- Capture correlationId from `--debug` output
- Search in Entra ID > Monitoring > Sign-in logs

## Service Principal Validation
```bash
az ad sp show --id <appId>
az role assignment list --assignee <appId> --all
```

## Common Resolutions
| Problem | Resolution |
|---------|------------|
| AADSTS53000 | Check Conditional Access network/location policy |
| AADSTS700016 | App registration missing or wrong tenant |
| AADSTS700082 | Inactive refresh token; re-login |
| insufficient privileges | Assign least privilege role (e.g., Reader) |
