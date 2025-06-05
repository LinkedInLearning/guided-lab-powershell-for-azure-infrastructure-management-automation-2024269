# Applying Pester to Azure Resource testing
Set-Location .\code\04_04\

# Connect to Azure once here
Connect-AzAccount - tenant 'EnterTenantId'

# Call a folder of Pester tests
Invoke-Pester .\Tests -Output Detailed