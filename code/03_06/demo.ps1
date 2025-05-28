# Create a key vault
$kvParams = @{
    Name     = 'kv-linkedinpwsh-prod-001'
    Location = 'UkSouth'
    ResourceGroupName = 'rg-linkedinpwsh-prod-001'
}
New-AzKeyVault @kvParams

# RBAC permissions
$roleAssignment = @{
    SignInName = 'upn'
    RoleDefinitionName = 'Key Vault Secrets Officer'
    Scope = '/subscriptions/****-****-****-****/resourceGroups/rg-linkedinpwsh-prod-001/providers/Microsoft.KeyVault/vaults/kv-linkedinpwsh-prod-001'
}
New-AzRoleAssignment @roleAssignment

# Create an admin password
$secretValue = Read-Host -Prompt 'Enter the example password' -AsSecureString
Set-AzKeyVaultSecret -VaultName 'kv-linkedinpwsh-prod-001' -Name 'SQLServer-SvrAdmin' -SecretValue $secretValue
