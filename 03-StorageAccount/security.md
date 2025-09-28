# Storage Security Considerations

| Control | Recommendation |
|---------|---------------|
| Public Access | Disable at account + container |
| Shared Key | Disable to force AAD |
| TLS | Enforce TLS1_2 or higher |
| Network | Use Private Endpoints + deny by default |
| RBAC | Assign least privilege (e.g., Storage Blob Data Reader) |
| Encryption | Customer-managed key if compliance requires |
| SAS | Short expiry, HTTPS only, minimal permissions |
